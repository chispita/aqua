# -*- coding: utf-8 -*-
import shutil
import Image
import formencode

from functions import *
from webhelpers import paginate

#from pylons.controllers.util import redirect
#from routes import url_for

from tedx.lib.base import *
from pylons.i18n import _

from pylons.decorators.rest import dispatch_on
from pylons.decorators import validate
from formencode.validators import Invalid, FancyValidator
from formencode.validators import Int, DateConverter, String, OneOf
from formencode.variabledecode import NestedVariables

#from formencode import variabledecode
from formencode import htmlfill
#from formencode.foreach import ForEach
#from formencode.api import NoDefault

from tedx.lib.validators import BaseSchema

import logging
log = logging.getLogger(__name__)

from sqlalchemy import func

class ChlorineValidator(FancyValidator):
    def _to_python(self, value, state):
        try:
            ph = float(value or 0)
        except:
            raise Invalid(_(u'Intrdoduce un valor valido'), value, state)
            return value

        ph = float(value or 0)
        if ph <0 or ph >2:
            raise Invalid(_(u'Debe de estar entre 0 y 2'), value, state)
            return value

class PhValidator(FancyValidator):
    def _to_python(self, value, state):
        try:
            ph = float(value or 0)
        except:
            raise Invalid(_(u'Intrdoduce un valor valido'), value, state)
            return value

        ph = float(value or 0)
        if ph <0 or ph >14:
            raise Invalid(_(u'Debe de estar entre 0 y 14'), value, state)
            return value

class PlaceSchema(BaseSchema):
    function='NewPlaceSchema'
    log.debug(function)

    name=String(not_empty=True)
    description=String(not_empty=True)
    ph = PhValidator(not_empty=True)
    chlorine = ChlorineValidator(not_empty=True)

class NewPlaceSchema(BaseSchema):
    function='NewPlaceSchema'
    log.debug(function)

    place = PlaceSchema()
    pre_validators = [NestedVariables]

class UpdatePlaceSchema(BaseSchema):
    place = PlaceSchema()
    pre_validators = [NestedVariables]

class PlacesController(BaseController):

    def index(self):
        ''' Get list of places in the system '''
        function = 'index'
        log.debug(function)

        page = 1
        if request.GET.has_key('page'):
            page = request.GET['page']

        c.ListPlaces = paginate.Page(
            getLastPlaces(),
            page = page,
            items_per_page=5)

        page = 1

        return render('/places/index.mako')

    def detail(self, id):
        ''' Get Detail of the place '''
        function = 'detail'
        log.debug(function)

        c.place  = meta.Session.query(Place).filter_by(id=id).first()

        page = 1
        if request.GET.has_key('page'):
            page = request.GET['page']

        c.ListComments = paginate.Page(
            getCommentsPlace(c.place.id),
            page = page,
            items_per_page=5)

        return render('/places/detail.mako')

    @dispatch_on(POST="_new")
    def new(self):
        function = 'new'
        log.debug(function)

        if c.user is None:
            abort(401)

        defaults = None
        '''
        Podemos poner valores por defecto
        defaults = {
                    'place.ph': '5',
                    'place.chlorine':'1.1',
                    }
        '''

        form = render('/places/new.mako')
        return htmlfill.render(form, defaults)

    @validate(schema=NewPlaceSchema(), form='new', post_only=True, on_get=True, variable_decode=True)
    def _new(self):
        function = '_new'
        log.debug(function)

        # Recuperamos los datos
        title = self.prm('place.name')
        content = self.prm('place.description')

        ph = self.prm('place.ph')
        chlorine = self.prm('place.chlorine')

        latitude = float(self.prm('place.latitude') or 0)
        longitude = float(self.prm('place.longitude') or 0)

        image_link = request.params.get('place.image')

        # Grabar todos los datos
        place = c.user.add_place(latitude, longitude, None, None, title)
        db_comment = place.add_comment(c.user, content, title)
        db_water = place.add_water(ph, chlorine)

        # Grabacion de la imagen
        if (image_link != None and image_link != ""):
            UploadFile( db_comment, image_link)

        h.flash(_(u'La muestra se ha grabado correctamente'))
        redirect(h.url_for(controller='home', action='index'))


    #@authorize(h.auth.is_valid_user)
    @dispatch_on(POST="_edit")
    def edit(self, id):
        # We need to recheck auth in here so we can pass in the id
        '''
        if not h.auth.authorized(h.auth.Or(h.auth.is_same_zkpylons_user(id), h.auth.has_organiser_role)):
            # Raise a no_auth error
            h.auth.no_role()
        '''
        c.form = 'edit'
        c.place  = meta.Session.query(Place).filter_by(id=id).first()
        if not c.place:
            abort(404)

        if c.place.user_id != c.user.id:
            abort(401)

        defaults = h.object_to_defaults(c.place, 'place')

        if c.place.comments[0]:
            defaults['place.description'] = c.place.comments[0].content

        form = render('/places/edit.mako')
        return htmlfill.render(form, defaults)

    @validate(schema=UpdatePlaceSchema(), form='edit', post_only=True, on_get=True, variable_decode=True)
    def _edit(self, id):
        ''' Update Place '''
        function = '_edit'
        log.debug(function)

        # We need to recheck auth in here so we can pass in the id
        #if not h.auth.authorized(h.auth.Or(h.auth.is_same_zkpylons_user(id), h.auth.has_organiser_role)):
            # Raise a no_auth error
            # h.auth.no_role()

        #c.person = Person.find_by_id(id)
        #self.finish_edit(c.person)


        place  = meta.Session.query(Place).filter_by(id=id).first()
        if place:

            place.last_update = datetime.datetime.now()
            place.name = self.prm('place.name')

            log.debug('%s - place:%s' % (function, place.id))
            log.debug('%s - fecha:%s' % (function, place.last_update))
            log.debug('%s - title:%s' % (function, place.name))

            meta.Session.commit()
        else:

            log.debug('%s - place:%s' % (function, place.id))
            log.debug('%s - no encontrado' % (function))

        '''
        content = self.prm('place.description')


        latitude = float(self.prm('place.latitude') or 0)
        longitude = float(self.prm('place.longitude') or 0)

        image_link = request.params.get('image')
        log.debug('%s - image-link:%s' % ( function, str(image_link)))

        # Grabar todos los datos
        place = c.user.add_place(latitude, longitude, None, None, title)
        db_comment = place.add_comment(c.user, content, title)
        db_water = place.add_water(ph, chlorine)
        '''


        #redirect_to(action='detail', id=id)

        h.flash(_(u'La muestra se ha actualizado correctamente'))
        redirect(h.url_for(action='index'))


    def delete(self,id):
        ''' Borrar una muestra '''
        place  = meta.Session.query(Place).filter_by(id=id).first()

        if not place:
            abort(404)

        if place.user_id != c.user.id:
            abort(401)

        ''' No lo borramos, solo actulizamos la fecha en deleted_on '''
        place.remove()

        h.flash(_(u'Se ha borrado la muestra correctamente'))
        redirect(h.url_for(controller='home', action='index'))

