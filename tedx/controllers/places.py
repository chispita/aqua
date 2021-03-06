# -*- coding: utf-8 -*-
import shutil
import Image
import formencode
import datetime

from functions import *
from webhelpers import paginate

#from pylons.controllers.util import redirect
#from routes import url_for

from tedx.lib.base import *
from pylons.i18n import _

from formencode import validators, Invalid
from pylons.decorators.rest import dispatch_on
from pylons.decorators import validate
from formencode.validators import Invalid, FancyValidator
from formencode.validators import Int, DateConverter, String, OneOf, Number
from formencode.variabledecode import NestedVariables

#from formencode import variabledecode
from formencode import htmlfill
#from formencode.foreach import ForEach
#from formencode.api import NoDefault

from tedx.lib.validators import BaseSchema
from geopy import geocoders

import logging
log = logging.getLogger(__name__)

from sqlalchemy import func

class ConvertDecimalValidator(validators.FancyValidator):

    function='ConvertDecimalValidator'
    log.debug(function)
    #def __init__(self, field_name):
    #    function='ConvertDecimalValidator 1'
    #    log.debug('%s - field_name:%s' % (function, field_name))

    def convert_to_python(self, value, state):
        function='ConvertDecimalValidator 2'
        log.debug('%s - value:%s' % (function, value))
        return '22'

    def validate_python(self, value, state):
        function='ConvertDecimalValidator 3'
        log.debug('%s - value:%s' % (function, value))
        return 22
'''
    def validate_python(self, values, state):
        function='ConvertDecimalValidator'
        log.debug(function)

        numeric = values['ph']
        log.debug('%s replace: %s' % (function, str(numeric.replace(',','.'))))
        values['ph']=3
        log.debug('%s ph:%s' % ( function, values['ph']))
        return 2
'''

'''
class ConvertDecimalValidator(validators.FormValidator):
    function='ConvertDecimalValidator'
    log.debug(function)

    validate_partial_form = True
    def __init__(self, field_name):

        function='ConvertDecimalValidator 1'
        #super(self.__class__, self).__init__()
        #self.field_name = field_n

        log.debug('%s validate partial%s' % (function, field_name))
        #log.debug('%s - field:%s' % ( function, field_name))
        #set(self.fieldname, '33')
        #values.set(self.__field_name, '33')


    def validate_partial(self, values, state):
        function='ConvertDecimalValidator -2'
        log.debug('%s validate partial' % function)
        values.set(self.__field_name, '33')
        ##agree_value = values.get(self.__field_name, None)
'''

class PlaceSchema(BaseSchema):
    function='NewPlaceSchema'
    log.debug(function)

    #log.debug('%s name:%s' % (function, name))
    name=String(not_empty=True)
    description=String()

    ##pre_validators = [ConvertDecimalValidator("ph")]
    ##ph = ConvertDecimalValidator()

    ph = Number(
            not_empty=True,
            min=0.9, max=14.1,
            messages={
                'tooHigh' : _(u'El valor del ph no debe superar 14'),
                'tooLow'  : _(u'El valor del ph no debe ser inferior 1')
                }
            )
    chlorine = Number(
            not_empty=True,
            min=0, max=2.1,
            messages={
                'tooHigh' : _(u'El valor del ph no debe superar 2'),
                'tooLow'  : _(u'El valor del ph no debe ser inferior a 0')
                }
            )
    latitude = Number(
            not_empty=True,
            messages={
                'empty':_(u'Debe seleccionar una posición en el mapa')
                }
            )
    date = validators.DateConverter(month_style='dd/mm/yyyy')
    time = validators.TimeConverter(use_datetime=True)

class NewPlaceSchema(BaseSchema):
    function='NewPlaceSchema'
    log.debug(function)

    place = PlaceSchema()
    pre_validators = [NestedVariables]

class UpdatePlaceSchema(BaseSchema):
    place = PlaceSchema()
    pre_validators = [NestedVariables]

class PlacesController(BaseController):
    def _base(self):
        page = 1
        if request.GET.has_key('page'):
            page = request.GET['page']

        c.ListPlaces = paginate.Page(
            getLastPlaces(),
            page = page,
            items_per_page=5)

        page = 1

        c.places_map = getAllPlaces()

    def _basedetail(self,id):
        c.place  = Place.find_by_id(id)

        c.places_map = getAllPlaces()

        if c.place is None:
            abort(404)

        page = 1
        if request.GET.has_key('page'):
            page = request.GET['page']

        c.ListComments = paginate.Page(
            getCommentsPlace(c.place.id),
            page = page,
            items_per_page=5)

    def index(self):
        ''' Get list of places in the system '''
        function = 'index'
        log.debug(function)

        c.top_places = getTopPlaces()

        self._base()
        return render('/places/index.mako')

    def detail(self, id):
        ''' Get Detail of the place '''
        function = 'detail'
        log.debug(function)

        self._basedetail(id)

        return render('/places/detail.mako')

    @dispatch_on(POST="_new")
    def new(self):
        function = 'new'
        log.debug(function)

        if c.user is None:
            abort(401)

        defaults = None

        #Podemos poner valores por defecto
        now = datetime.datetime.now()
        defaults = {
                    'place.date': now.strftime("%d/%m/%Y"),
                    'place.time': now.strftime("%H:%M"),
                    }

        form = render('/places/new.mako')
        return htmlfill.render(form, defaults)

    @validate(schema=NewPlaceSchema(), form='new', post_only=True, on_get=True, variable_decode=True)
    def _new(self):
        function = '_new'
        log.debug(function)

        # Recuperamos los datos
        results = self.form_result['place']

        name = results['name']
        description = results['description']
        ph = results['ph']
        chlorine = results['chlorine']
        latitude = float(self.prm('place.latitude') or 0)
        longitude = float(self.prm('place.longitude') or 0)
        take_on = datetime.datetime.combine( results['date'], results['time'])
        image_link = request.params.get('place.image')

        # Buscar los valores de la calle, ...
        address, city, postalcode, country = getLocation( latitude, longitude)

        # Grabar todos los datos
        place = c.user.add_place(latitude, longitude, name, address, city, postalcode, country, description, take_on)
        db_water = place.add_water(ph, chlorine)

        # Grabacion de la imagen
        log.debug('%s - image_link: %s' % (function, image_link))

        if (image_link != None and image_link != ""):
            log.debug('%s imagen' % function)
            db_comment = place.add_comment(c.user, description, name)
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

        self._basedetail(id)

        defaults = h.object_to_defaults(c.place, 'place')

        defaults['place.date'] =  c.place.take_on.strftime("%d/%m/%Y")
        defaults['place.time'] =  c.place.take_on.strftime("%H:%M")

        form = render('/places/edit.mako')
        return htmlfill.render(form, defaults)

    @validate(schema=UpdatePlaceSchema(), form='edit', post_only=True, on_get=True, variable_decode=True)
    def _edit(self, id):
        ''' Update Place '''
        function = '_edit'
        log.debug(function)

        # Recuperamos los datos
        results = self.form_result['place']

        c.place  = Place.find_by_id(id)
        c.place.name = results['name']
        c.place.description = results['description']
        log.debug('%s desc: %s' % (function, results['description']))
        c.place.ph = results['ph']
        c.place.chlorine = results['chlorine']
        c.place.take_on = datetime.datetime.combine( results['date'], results['time'])
        c.place.last_update = datetime.datetime.now()

        #image_link = request.params.get('place.image')

        meta.Session.commit()

        h.flash(_(u'La muestra se ha actualizado correctamente'))
        redirect(h.url_for(action='index'))


    def delete(self,id):
        ''' Borrar una muestra '''
        c.place = Place.find_by_id(id)

        ''' No lo borramos, solo actulizamos la fecha en deleted_on '''
        c.place.remove()

        h.flash(_(u'Se ha borrado la muestra correctamente'))
        redirect(h.url_for(controller='home', action='index'))
