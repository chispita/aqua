# -*- coding: utf-8 -*-
import formencode
from formencode import validators, Invalid #, schema
from formencode.validators import Int, DateConverter, String, OneOf, Email, MinLength
from formencode.variabledecode import NestedVariables

from tedx.lib.base import *
from tedx.controllers.functions import CheckEmailUser, CheckNicknameUser
from pylons.i18n import _

import logging

log = logging.getLogger(__name__)

class BaseSchema(formencode.Schema):
    allow_extra_fields = True
    filter_extra_fields = True

class NotExistingEmailValidatorUpdate(validators.FancyValidator):

    function = 'NotExistingEmailUpdate'
    log.debug(function)
    def validate_python(self, values, state):
        person = CheckEmailUser( values['email'])

        if person is not None:
            msg = _(u'Ya esta registrado este correo. Intente logearse.')
            raise Invalid(msg, values, state, error_dict={'email': msg})

class NotExistingEmailValidator(validators.FancyValidator):

    function = 'NotExistingEmail'
    log.debug(function)
    def validate_python(self, values, state):
        person = User.find_by_email( values['email'] )

        if person is not None:
            msg = _(u'Ya esta registrado este correo. Intente logearse.')
            raise Invalid(msg, values, state, error_dict={'email': msg})

class NotExistingNickValidatorUpdate(validators.FancyValidator):
    function = 'NotExistingNickUpdate'
    log.debug(function)

    def validate_python(self, values, state):
        function = 'NotExistingNickUpdate'
        log.debug('%s validate' % function)
        person = CheckNicknameUser( values['name'] )
        if person is not None:
            msg = _(u'Ya esta registrado el nombre de usuario.')
            raise Invalid(msg, values, state, error_dict={'name': msg})

class NotExistingNickValidator(validators.FancyValidator):
    ''' Check if there is in the system a nickname registrated yet'''
    function = 'NotExistingNick'
    log.debug(function)

    def validate_python(self, values, state):
        person = User.find_by_name( values['name'] )
        if person is not None:
            msg = _(u'Ya esta registrado el nombre de usuario.')
            raise Invalid(msg, values, state, error_dict={'name': msg})

class UserValidator(validators.FancyValidator):
    function = 'UserSchema'
    log.debug( function )

    def validate_python(self, values, state):
        message = _(u'Fallo en el login')
        error_dict = {'email': message}
        raise Invalid(message, values, state, error_dict=error_dict)

class SameEmailAddress(validators.FancyValidator):
    function = 'UserSchema'
    log.debug( function )

    def validate_python(self, values, state):
        if values['email_address'] != values['email_address2']:
            msg = _(u'Las direcciones de correos no coinciden')
            raise Invalid(msg, values, state, error_dict={'email_address2': msg})

class UserSchema(BaseSchema):
    function = 'UserSchema'
    log.debug( function )

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
