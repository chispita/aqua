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
from formencode.validators import Int, DateConverter, String, OneOf
from formencode.variabledecode import NestedVariables
from formencode import htmlfill

from tedx.lib.validators import BaseSchema
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
            error_dict = {'email': _(u'No existe un usuario registrado con este correo.')}
            raise Invalid(message, values, state, error_dict=error_dict)

        #elif not person.deleted_on:
        #    error_message = "You haven't yet confirmed your registration, please refer to your email for instructions on how to do so."

        if person.password != hashlib.md5(values['password']).hexdigest():
            error_dict = {'password': _(u'La contraseña no es correcta, intente recuperarla.')}
            raise Invalid(message, values, state, error_dict=error_dict)

class LoginPersonSchema(BaseSchema):
    function = 'LoginPersonSchema'
    log.debug(function)
    email = validators.Email(not_empty=True)
    password = validators.String(not_empty=True)
    chained_validators = [AuthPersonValidator()]

class LoginSchema(BaseSchema):
    function = 'LoginSchema'
    log.debug(function)
    person = LoginPersonSchema()
    pre_validators = [NestedVariables]

class AccountController(BaseController):

    def index(self):
        ''' Get list accounts in the system '''

        page = 1
        if request.GET.has_key('page'):
            page = request.GET['page']

        c.Users= paginate.Page(
            getAllUsers(),
            page = page,
            items_per_page=5)

        c.AllPlaces = getAllPlaces()
        return render('/accounts/index.mako')

    @dispatch_on(POST="_signin")
    def signin(self):
        return render('/accounts/signin.mako')

    @validate(schema=LoginSchema(), form='signin', post_only=True, on_get=False, variable_decode=True)
    def _signin(self):

        email = self.prm('person.email')

        person =  meta.Session.query(User).filter_by(email=email).first()

        session['user_id'] = person.id
        session.save()

        h.flash( _(u'Bienvenido ')+ '' + person.nickname)
        redirect(h.url_for(controller='home'))


    @dispatch_on(POST="_forgotten_password")
    def forgotten_password(self):
        return render('/accounts/forgotten_password.mako')

    @validate(schema=ForgottenPasswordSchema(), form='forgotten_password', post_only=True, on_get=True, variable_decode=True)
    def _forgotten_password(self):

        c.email = self.form_result['email']
        c.person = User.find_by_email(c.email)

        if c.person is None:
            h.flash(_(u'No se ha encontrado ningun usuario con el correo introducido'))
            redirect(h.url_for(action='forgotten_password'))
        else:

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
        log.debug('%s nickname:%s' % (function, nickname))

        c.user_search= meta.Session.query(User).filter(and_(User.nickname==nickname,User.deleted_on==None)).first()

        page = 1
        if request.GET.has_key('page'):
            page = request.GET['page']

        c.places_map = getProfilePlaces(nickname)
        c.places = paginate.Page(
            getProfilePlaces(nickname),
            page = page,
            items_per_page=5)

        return render('/accounts/public_profile.mako')


    def profile(self):
        ''' Get private profile of the .iduser '''
        function='def profile'
        log.debug(function)
        log.debug('%s nickname:%s' % (function, c.user.nickname))

        c.user_search= meta.Session.query(User).filter(and_(
            User.nickname==c.user.nickname,
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

        return render('/accounts/profile.mako')

    def settings(self):
        ''' Edit profile of the user '''
        function='def settings'
        log.debug(function)

        log.debug('%s - user' % (function))
        c.user_search= meta.Session.query(User).filter(and_(
            User.nickname==c.user.nickname,
            User.deleted_on==None
            )).first()
        log.debug('%s - user:%s' % (function, c.user_search))

        page = 1
        if request.GET.has_key('page'):
            page = request.GET['page']

        c.places_map = getProfilePlaces(c.user_search.nickname)
        c.places = paginate.Page(
            getProfilePlaces(c.user_search.nickname),
            page = page,
            items_per_page=5)

        log.debug('%s - user:%s' % (function, c.user_search))

        return render('/accounts/settings.mako')

    def comments(self,nickname):
        ''' Get comments of the user '''
        function='def comments'
        log.debug(function)

        c.user_search= meta.Session.query(User).filter(and_(User.nickname==nickname,User.deleted_on==None)).first()

        page = 1
        if request.GET.has_key('page'):
            page = request.GET['page']

        c.places_map = getProfilePlaces(c.user_search.nickname)


        c.Comments = paginate.Page(
            getProfileComments(c.user_search.nickname),
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


    def get_details(self):
        if c.user:
            return h.toJSON({
                "status": "OK",
                "user_id": c.user.id,
                "user_nickname": c.user.nickname,
                "user_description":c.user.description,
                "user_mail": c.user.email,
                'avatar':c.user.avatar,
                'latitude': c.user.latitude,
                'longitude': c.user.longitude })
        else:
            return h.toJSON({
                "status": "NOK",
                "message": _(u"couldnt_get_info"),
                'error_code': 1})

    def get_stats(self):
        if c.user:
            videos = 0
            images = 0
            links = 0
            visits = 0
            positive_scorings = 0
            negative_scorings = 0

            visits = meta.Session.query(func.sum(Place.visits)).filter(Place.user_id == c.user.id).scalar()
            positive_scorings = meta.Session.query(func.sum(Place.positive_scorings.any())).filter(Place.user_id == c.user.id)
            aux = meta.Session.query(func.sum(Comment.positive_scorings.any())).filter(Comment.user_id == c.user.id)
            positive_scorings = aux.scalar() + positive_scorings.scalar();
            places = meta.Session.query(Place).filter(Place.user_id == c.user.id).count()
            comments = meta.Session.query(Comment).filter(Comment.user_id == c.user.id).count()
            return h.toJSON({"status": "OK", "places": places, "comments":comments,
                             "visits":visits, "positive_scorings":positive_scorings })

        else:
            return h.toJSON({"status": "NOK", "message": _(u"couldnt_get_info"), 'error_code': 1})


    def get_position(self):
        if c.user and c.user.latitude and c.user.longitude:
            return h.toJSON({"status": "OK", 'latitude': c.user.latitude, 'longitude': c.user.longitude})
        else:
            return h.toJSON({"status": "NOK", "message": _(u"couldnt_get_location"), 'error_code': 0})

    def upload_avatar(self):
        file = request.params.get('file')
        if file is not None and file != '':
            name = file.name
            folder = c.user.id.lstrip(os.sep)
            if not os.path.isdir(os.path.join(os.getcwd(), 'tedx/public/avatars/', folder)):
                os.mkdir(os.path.join(os.getcwd(), 'tedx/public/avatars/', folder))

            full_path = os.path.join(os.getcwd(), 'tedx/public/avatars/', folder, folder)
            permanent_file = open(full_path, 'w')

            shutil.copyfileobj(file.file, permanent_file)
            file.file.close()
            permanent_file.close()
            c.user.avatar = "/avatars/" + folder + "/" + folder

            try:
                im = Image.open(os.path.join(os.getcwd(),'tedx/public/avatars/', folder, folder))
            except Exception, e:
                print e
                os.remove(os.path.join(os.getcwd(),'tedx/public/avatars/', folder, folder))
                return h.toJSON({'status': 'NOK', 'message': _(u'file_selected_is_not_an image'), 'error_code': 0})

            im = im.convert('RGB')
            width, height = im.size
            filename = folder + '.png'
            filenamemid = folder + '_mid.png'
            filenamemini = folder + '_small.png'
            out = im
            outmid = im
            outmini = im
            imAspect = float(width)/float(height)

                    # Avatar
            if width >app_globals.default_image_size or height >app_globals.default_image_size:
                if width > height:
                    out = im.resize((app_globals.default_image_size,int(float(app_globals.default_image_size) / imAspect)), Image.ANTIALIAS)
                else:
                    out = im.resize((int(float(app_globals.default_image_size) * imAspect),app_globals.default_image_size), Image.ANTIALIAS)

            # image medio
            if width >app_globals.mid_image_size or height >app_globals.mid_image_size:
                if width > height:
                    outmid = im.resize((app_globals.mid_image_size,int(float(app_globals.mid_image_size) / imAspect)), Image.ANTIALIAS)
                else:
                    outmid = im.resize((int(float(app_globals.mid_image_size) * imAspect),app_globals.mid_image_size), Image.ANTIALIAS)

            # image pequeño
            if width >app_globals.small_image_size or height >app_globals.small_image_size:
                if width > height:
                    outmini = im.resize((app_globals.small_image_size,int(float(app_globals.small_image_size) / imAspect)), Image.ANTIALIAS)
                else:
                    outmini = im.resize((int(float(app_globals.small_image_size) * imAspect),app_globals.small_image_size), Image.ANTIALIAS)

            out.save(os.path.join(os.getcwd(),'tedx/public/avatars/', folder, filename.lstrip(os.sep)))
            outmid.save(os.path.join(os.getcwd(),'tedx/public/avatars/', folder, filenamemid.lstrip(os.sep)))
            outmini.save(os.path.join(os.getcwd(),'tedx/public/avatars/', folder, filenamemini.lstrip(os.sep)))
            os.remove(os.path.join(os.getcwd(),'tedx/public/avatars/', folder, folder))


            meta.Session.add(c.user)
            meta.Session.commit()

            return h.toJSON({'status': 'OK', 'message': 'OK'})
        return h.toJSON({'status': 'NOK', 'message': _(u'error_saving_file'), 'error_code': 0})


