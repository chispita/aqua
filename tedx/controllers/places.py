# -*- coding: utf-8 -*-
import shutil
import Image
import formencode

from functions import *
from webhelpers import paginate

from tedx.lib.base import *
from pylons.i18n import _

#from pylons.decorators import validate
#from pylons.decorators.rest import dispatch_


import logging
log = logging.getLogger(__name__)

from sqlalchemy import func

class PlaceForm(formencode.Schema):
    allow_extra_fields = True
    filter_extra_fields = True
    email = formencode.validators.Email(not_empty=True)
    date = formencode.validators.DateConverter(not_empty=True)

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
        return render('/places/detail.mako')


    #@dispatch_on(POST="_new")
    ##def new(self, cat_id=None):
    def new(self):
        function = 'new'
        log.debug(function)
        form=render('/places/new.mako')

        return form
        '''
        if cat_id is None:
            return form
        else:
            return htmlfill.render(form, {
                'product.category': cat_id,
                'product.category_id': cat_id})
        '''

    '''
    @validate(schema=NewProductSchema(), form='new', post_only=True, on_get=True, variable_decode=True)
    '''

    def _new(self):
        function = '_new'
        log.debug(function)

        results = self.form_result['place']

        #c.product = Product(**results)
        #meta.Session.add(c.product)
        #meta.Session.commit()

        h.flash("Muestra creada")
        #redirect_to(action='view', id=c.product.id)

    #def new(self):
    #    ''' New Place '''
    #    function = 'new'
    #    log.debug(function)

    #    return render('/places/new.mako')

        return render('/places/index.mako')


    def save(self):
        function = 'save'
        log.debug(function)
        log.debug('%s - params:%s' % ( function, request.params))

        c.place_msg = ''
        c.name_value = ''
        name = request.params.get('name')
        if not name:
            log.debug('%s - not name' % (function))
            c.place_msg= "Introduce un valor"

        if c.place_msg:
            c.name_value = name
            return render('/places/new.mako')
        else:
            log.debug('%s - name:%s' % (function,name))
            return 'Your name is:%s' % name

    def edit(self):
        function = 'edit'
        log.debug(function)

        return 'Edit'

    def delete(self):
        function = 'delete'
        log.debug(function)

        return 'Delete'




