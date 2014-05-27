# -*- coding: utf-8 -*-
import string
import shutil
import Image
import formencode
from formencode import validators, Invalid #, schema

from functions import *
from webhelpers import paginate

from tedx.lib.base import *
from pylons.i18n import _

from pylons.decorators.rest import dispatch_on
from pylons.decorators import validate

from formencode.validators import Invalid, FancyValidator
from formencode.validators import Int, DateConverter, String, OneOf, MinLength

from formencode.variabledecode import NestedVariables
from formencode import htmlfill

from tedx.lib.validators import BaseSchema, NotExistingNickValidator, NotExistingEmailValidator, NotExistingNickValidatorUpdate, NotExistingEmailValidatorUpdate

from tedx.lib.mail import email

import logging
log = logging.getLogger(__name__)

from sqlalchemy import func

class ForgottenPasswordSchema(BaseSchema):
    email = validators.Email(not_empty=True)

class AuthPersonValidator(validators.FancyValidator):
    def validate_python(self, values, state):
        person =  meta.Session.query(User).filter_by(email=values['email']).first()
        error_message = None
        if person is None:
            message = _(u'Fallo de usuario')
            error_dict = {'email': _(u'No existe un usuario registrado con este correo.')}
            raise Invalid(message, values, state, error_dict=error_dict)

        if person.password != hashlib.md5(values['password']).hexdigest():
            message = _(u'Fallo en la contraseña')
            error_dict = {'password': _(u'La contraseña no es correcta.')}
            raise Invalid(message, values, state, error_dict=error_dict)

class LoginPersonSchema(BaseSchema):
    function = 'LoginPersonSchema'
    log.debug(function)

    email = validators.Email(not_empty=True)
    password = validators.String(not_empty=True)

    chained_validators = [AuthPersonValidator()]

class _PasswordResetPersonSchema(BaseSchema):

    password1 = validators.String(not_empty=True)
    password1 = MinLength(6)
    password2 = validators.String(not_empty=True)

    chained_validators = [validators.FieldsMatch('password1', 'password2')]

class PasswordResetPersonSchema(BaseSchema):
    function = 'PasswordResetPersonSchema'
    log.debug(function)

    reset= _PasswordResetPersonSchema()

    pre_validators = [NestedVariables]

class _UpdatePersonSchema(BaseSchema):
    function = '_UpdatePersonSchema'
    log.debug(function)

    name = validators.String(not_empty=True)
    email = validators.Email(not_empy=True)
    chained_validators =  [
            NotExistingNickValidatorUpdate(),
            NotExistingEmailValidatorUpdate()]

class UpdatePersonSchema(BaseSchema):
    function = 'UpdatePersonSchema'
    log.debug(function)

    register = _UpdatePersonSchema()
    pre_validators = [NestedVariables]

class LoginSchema(BaseSchema):
    function = 'LoginSchema'
    log.debug(function)
    person = LoginPersonSchema()
    pre_validators = [NestedVariables]

class AccountController(BaseController):

    def _base(self, nickname):
        c.user_search= meta.Session.query(User).filter(and_(
            User.nickname==nickname,
            User.deleted_on==None
            )).first()

        page = 1
        if request.GET.has_key('page'):
            page = request.GET['page']

        c.places_map = getProfilePlaces(c.user_search.nickname)

        c.places = paginate.Page(
            getProfilePlaces(c.user_search.nickname),
            page = page,
            items_per_page=5)

    def _baseAll(self):
        page = 1
        if request.GET.has_key('page'):
            page = request.GET['page']

        c.ListPlaces = paginate.Page(
            getLastPlaces(),
            page = page,
            items_per_page=5)

        page = 1

        c.places_map = getAllPlaces()

    def index(self):
        ''' Get list accounts in the system '''

        page = 1
        if request.GET.has_key('page'):
            page = request.GET['page']

        c.TopUser = getTopUsers()
        c.Users = paginate.Page(
            getAllUsers(),
            page = page,
            items_per_page=5)

        c.places_map = getAllPlaces()
        return render('/accounts/index.mako')

    @dispatch_on(POST="_signin")
    def signin(self):

        self._baseAll()

        return render('/accounts/signin.mako')

    @validate(schema=LoginSchema(), form='signin', post_only=True, on_get=False, variable_decode=True)
    def _signin(self):

        email = self.prm('person.email')
        person = User.find_by_email( email )

        session['user_id'] = person.id
        session.save()

        h.flash( _(u'Bienvenido ')+ '' + person.nickname)
        redirect(h.url_for(controller='home'))

    def signout(self):
        if 'user_id' in session:
            del session['user_id']
            session.save()

        h.flash(_(u'Te has desconectado del sistema'))
        redirect(h.url_for(controller='home'))

    @dispatch_on(POST="_forgotten_password")
    def forgotten_password(self):

        self._baseAll()
        return render('/accounts/forgotten_password.mako')

    @validate(schema=ForgottenPasswordSchema(), form='forgotten_password', post_only=True, on_get=True, variable_decode=True)
    def _forgotten_password(self):

        c.email = self.form_result['email']
        c.person = User.find_by_email(c.email)

        if c.person is not None:
            # Create and save the new password
            size = 9
            new_password = ''.join([choice(string.letters + string.digits) for i in range(size)])
            c.person.password = hashlib.md5(new_password).hexdigest()
            meta.Session.commit()

            c.password = new_password

            email(c.email, render('accounts/confirmation_email.mako'))

        msg  =  _(u'Para completar el proceso siga las instrucciones que se han mandado a la dirección de correo.')
        msg1 =  _(u'Si no recibe el correo en un tiempo razonable, contacte con ') + h.contact_email()
        h.flash(msg)
        h.flash(msg1)
        redirect(h.url_for(controller='home'))

    def public_profile(self, nickname):
        ''' Get public profile of the user '''
        function='def public_profile'
        log.debug(function)

        self._base(nickname)


        return render('/accounts/public_profile.mako')

    def profile(self):
        ''' Get private profile of the .iduser '''
        function='def profile'
        log.debug(function)

        self._base(c.user.nickname)

        return render('/accounts/profile.mako')

    @dispatch_on(POST="_settings")
    def settings(self):
        ''' Edit profile of the user '''
        function = "settings"
        log.debug(function)

        self._base(c.user.nickname)

        defaults = {
                    'register.name': c.user.nickname,
                    'register.email': c.user.email,
                    }

        form = render('/accounts/settings.mako')
        return htmlfill.render(form, defaults)

    @validate(schema=UpdatePersonSchema(), form='settings', post_only=False, on_get=True, variable_decode=True)
    def _settings(self,id):
        ''' Update profile '''
        function = '_settings'

        # Recuperamos los datos
        results = self.form_result['register']

        c.person = User.find_by_id(id)
        c.person.nickname = results['name']
        c.person.email = results['email']
        meta.Session.commit()

        h.flash( _(u'Se ha actualizado correctamente el péfil del usuario'))
        redirect(h.url_for(controller='account', action='profile'))

    @dispatch_on(POST="_password")
    def password(self):
        ''' Change password profile of the user '''

        self._base(c.user.nickname)
        defaults = { 'reset.email': c.user.email,}

        form = render('/accounts/reset.mako')
        return htmlfill.render(form, defaults)

    @validate(schema=PasswordResetPersonSchema(), form='password', post_only=False, on_get=True, variable_decode=True)
    def _password(self,id):
        ''' Update profile '''
        function = '_settings'

        # Recuperamos los datos
        results = self.form_result['reset']

        c.person = User.find_by_id(id)

        new_password = results['password2']
        c.person.password = hashlib.md5(new_password).hexdigest()
        meta.Session.commit()

        h.flash( _(u'Se ha actualizado correctamente su contraseña'))
        redirect(h.url_for(controller='account', action='profile'))

    def comments(self,nickname):
        ''' Get comments of the user '''
        function='def comments'
        log.debug(function)

        c.user = User.find_by_name( nickname)

        c.places_map = getProfilePlaces(c.user.nickname)

        page = 1
        if request.GET.has_key('page'):
            page = request.GET['page']

        c.places_map = getProfilePlaces(c.user.nickname)

        c.Comments = paginate.Page(
            getProfileComments(c.user.nickname),
            page = page,
            items_per_page=5)

        return render('/accounts/comments.mako')


    def visits(self,nickname):
        ''' Get visits of the user '''
        function='def visits'
        log.debug(function)

        c.user_search= meta.Session.query(User).filter(and_(User.nickname==nickname,User.deleted_on==None)).first()

        page = 1
        if request.GET.has_key('page'):
            page = request.GET['page']

        c.places_map = getProfilePlaces(c.user_search.nickname)
        c.places = paginate.Page(
            getProfilePlaces(c.user_search.nickname),
            page = page,
            items_per_page=5)

        return render('/accounts/visits.mako')

    def stats(self):
        ''' Get stats per user '''
        function = 'stats'
        log.debug(function)
        c.bicolor = "gray"

        if c.user is None:
            abort(404)

        visits = 0
        places = 0
        comments = 0

        like = 0
        aux = 0

        c.visits = meta.Session.query(func.sum(Place.visits)).filter(Place.user_id == c.user.id).scalar()
        c.places = meta.Session.query(Place).filter(Place.user_id == c.user.id).count()
        c.comments = meta.Session.query(Comment).filter(Comment.user_id == c.user.id).count()

        #c.like = meta.Session.query(func.sum(Place.positive_scorings.any())).filter(Place.user_id == c.user.id)
        #c.aux = meta.Session.query(func.sum(Comment.positive_scorings.any())).filter(Comment.user_id == c.user.id)
        #c.positive_scorings = aux.scalar() + positive_scorings.scalar();
        return render('/stats.mako')

    def save(self):
        function = 'save'
        log.debug(function)
        email = self.prm('email')
        old_password = self.prm('old_password')
        new_password = self.prm('password')
        nickname = self.prm('nickname')
        latitude = self.prm('latitude')
        longitude = self.prm('longitude')
        description = self.prm('description')
        user_tags = self.prm('user_tags')

        if c.user:
            db_user = meta.Session.query(User).filter_by(id = c.user.id).first()
            log.debug('%s - db_user:%s old_password:%s' % (function, db_user, old_password))

            if old_password:
                if c.user.password == hashlib.md5(old_password).hexdigest():
                    c.user.password = hashlib.md5(new_password).hexdigest()
                else:
                    return h.toJSON({"status": "NOK", "message": _(u"La contraseña antigua no coincide!"), 'error_code': 0})

            c.user.description = description
            c.user.latitude = latitude
            c.user.longitude = longitude
            c.user.nickname = nickname

            for tag in c.user.tags:
                c.user.remove_tag(tag)
            if user_tags:
                tags = user_tags.split(' ')
                for tag in tags:
                    db_tag = meta.Session.query(Tag).filter(Tag.name == tag).first()
                    if db_tag is None:
                        Tag(tag)
                        db_tag = meta.Session.query(Tag).filter(Tag.name == tag).first()
                    c.user.add_tag(db_tag)


            session['user_id'] = c.user.id
            session.save()

            meta.Session.add(c.user)
            meta.Session.commit()

            return h.toJSON({"status": "OK", "message": _(u"data_successfully_saved")})
        else:
            return h.toJSON({"status": "NOK", "message": _(u"couldnt_save_profile"), 'error_code': 1})
