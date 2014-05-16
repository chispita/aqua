# -*- coding: utf-8 -*-
import formencode
from formencode import validators, Invalid #, schema

from tedx.lib.base import *
from pylons.i18n import _

from pylons.decorators.rest import dispatch_on
from pylons.decorators import validate

from formencode.validators import Invalid, FancyValidator
from formencode.validators import Int, DateConverter, String, OneOf, Email, MinLength
from formencode.variabledecode import NestedVariables
from formencode import htmlfill

from tedx.lib.validators import BaseSchema

from sqlalchemy import func

import logging
log = logging.getLogger(__name__)


class UserValidator(validators.FancyValidator):
    def validate_python(self, values, state):
        function ='UserValidator'
        log.debug(function)
        #assertion = values['assertion']
        #audience = h.url_for(qualified=True, controller='home').strip("/")

        #page = urllib2.urlopen('https://verifier.login.persona.org/verify',
        #c.person = Person.find_by_email(c.email)
        #if c.person is None:
        #if not lca_info['account_creation']:
        error_message = "Your sign-in details are incorrect; try the 'Forgotten your password' link below."
        message = "Login failed"
        error_dict = {'email': error_message}
        raise Invalid(message, values, state, error_dict=error_dict)

class SameEmailAddress(validators.FancyValidator):
    def validate_python(self, values, state):
        if values['email_address'] != values['email_address2']:
            msg = 'Email addresses don\'t match'
            raise Invalid(msg, values, state, error_dict={'email_address2': msg})

class NotExistingEmailValidator(validators.FancyValidator):
    ''' Check if there is in the system a email registrated yed'''
    def validate_python(self, values, state):
        person = meta.Session.query(User).filter_by(email=values['email']).first()
        if person is not None:
            msg = _(u'Ya esta registrado este correo. Intente logearse.')
            raise Invalid(msg, values, state, error_dict={'email': msg})

class NotExistingNickValidator(validators.FancyValidator):
    ''' Check if there is in the system a nickname registrated yed'''
    def validate_python(self, values, state):
        person = meta.Session.query(User).filter_by(nickname=values['name']).first()
        if person is not None:
            msg = _(u'Ya esta registrado el nombre de usuario.')
            raise Invalid(msg, values, state, error_dict={'name': msg})

class UserSchema(BaseSchema):
    name = String(not_empty=True)
    email = Email(not_empty=True)
    password = String(not_empty=True)
    password = MinLength(6)
    password2 = String(not_empty=True)

    chained_validators =  [
            NotExistingNickValidator(),
            NotExistingEmailValidator(),
            validators.FieldsMatch('password', 'password2')
            ]

class NewUserSchema(BaseSchema):
    register = UserSchema()
    pre_validators = [NestedVariables]
    #pre_validators = [UserValidator()]

class RegisterController(BaseController):

    def index(self):
        c.bicolor = 'gray'
        return render('register.mako')

    @dispatch_on(POST="_new")
    def new(self):
        function = 'new'
        log.debug(function)

        defaults = None
        form = render('registration/index.mako')
        return htmlfill.render(form, defaults)

    @validate(schema=NewUserSchema(), form='new', post_only=True, on_get=True, variable_decode=True)
    def _new(self):
        function = '_new'
        log.debug(function)

        email = self.prm('register.email')
        password = self.prm('register.password')
        nickname = self.prm('register.name')
        #latitude = self.prm('register.latitude')
        #longitude = self.prm('rlongitude')

        latitude = 0
        longitude = 0

        c.user = User(email, password, nickname, latitude, longitude)
        session['user_id'] = c.user.id
        session.save()

        h.flash(_(u'Se ha creado el usuario correctamente'))
        redirect(h.url_for(controller='home'))

    def save(self):
        email = self.prm('email')
        password = self.prm('password')
        nickname = self.prm('nickname')
        latitude = self.prm('latitude')
        longitude = self.prm('longitude')

        if not email:
            return h.toJSON({"status": "NOK", "message": _(u"email_cannot_be_null"), 'error_code': 0})
        elif not password:
            return h.toJSON({"status": "NOK", "message": _(u"password_cannot_be_null"), 'error_code': 0})

        db_user = meta.Session.query(User).filter_by(email=email).first()
        if db_user is not None:
            return h.toJSON({"status": "NOK", "message": _(u"email_already_registered"), 'error_code': 0})

        reserved_nicknames = ['about', 'common', 'content', 'error', 'home', 'notification', "my_account",
                              'profile', 'register', 'view', 'bidis', 'css', 'files', 'images', 'js', 'swf']
        db_user = meta.Session.query(User).filter_by(nickname=nickname).first()
        if db_user is not None or nickname in reserved_nicknames:
            return h.toJSON({"status": "NOK", "message": _(u"nickname_already_registered"), 'error_code': 0})

        c.user = User(email, password, nickname, latitude, longitude)

        session['user_id'] = c.user.id
        session.save()

        return h.toJSON({"status": "OK", "message": _(u"successfully_registered")})

