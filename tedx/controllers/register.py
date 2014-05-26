# -*- coding: utf-8 -*-
import formencode
from formencode import validators, Invalid #, schema

from tedx.lib.base import *
from pylons.i18n import _

from functions import *
from webhelpers import paginate
from pylons.decorators.rest import dispatch_on
from pylons.decorators import validate

from formencode.validators import Invalid, FancyValidator
from formencode.validators import Int, DateConverter, String, OneOf, Email, MinLength
from formencode.variabledecode import NestedVariables
from formencode import htmlfill

from tedx.lib.validators import BaseSchema, UserSchema

from sqlalchemy import func

import logging
log = logging.getLogger(__name__)

class NewUserSchema(BaseSchema):
    register = UserSchema()
    pre_validators = [NestedVariables]

class RegisterController(BaseController):

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
        return render('register.mako')

    @dispatch_on(POST="_new")
    def new(self):
        function = 'new'
        log.debug(function)

        self._baseAll()

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

