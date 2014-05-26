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
from formencode import htmlfill

from tedx.lib.validators import BaseSchema

import logging
log = logging.getLogger(__name__)

from sqlalchemy import func

class CommentSchema(BaseSchema):
    function='Commentchema'
    log.debug(function)

    title=String(not_empty=True)
    content=String(not_empty=True)

class NewCommentSchema(BaseSchema):
    function='NewCommentSchema'
    log.debug(function)

    comment = CommentSchema()
    pre_validators = [NestedVariables]

class UpdateCommentSchema(BaseSchema):
    comment = CommentSchema()
    pre_validators = [NestedVariables]

class CommentsController(BaseController):

    def index(self):
        ''' Get list of comments in the system '''
        function = 'index'
        log.debug(function)

        page = 1
        if request.GET.has_key('page'):
            page = request.GET['page']

        c.Comments = paginate.Page(
            getAllComments(),
            page = page,
            items_per_page=5)

        c.places_map = getAllPlaces()
        page = 1

        return render('/comments/index.mako')

    def detail(self, id):
        function = 'detail'
        log.debug(function)

        c.comment  = Comment.find_by_id(id)

        #Podemos poner valores por defecto
        defaults = None
        '''
        defaults = {
            'comment.place_id': place.id,
            }
        '''

        form = render('/comments/detail.mako')
        return htmlfill.render(form, defaults)

    @dispatch_on(POST="_new")
    def new(self, place_id):
        function = 'new'
        log.debug(function)

        if c.user is None:
            abort(401)

        c.place = Place.find_by_id(place_id)
        defaults = None

        form = render('/comments/new.mako')
        return htmlfill.render(form, defaults)

    @validate(schema=NewCommentSchema(), form='new', post_only=True, on_get=True, variable_decode=True)
    def _new(self,place_id):
        function = '_new'
        log.debug(function)

        place  = Place.find_by_id(place_id)

        # Recuperamos los datos
        title = self.prm('comment.title')
        content = self.prm('comment.content')
        image = request.params.get('comment.image')

        # Grabar todos los datos
        db_comment = place.add_comment(c.user, content, title)

        # Grabacion de la imagen
        if (image != None and image != ""):
            UploadFile( db_comment, image)

        h.flash(_(u'El comentario se ha grabado correctamente'))
        redirect(h.url_for(controller='places', action='detail', id=place_id))

    @dispatch_on(POST="_edit")
    def edit(self, id):
        function = 'edit'
        log.debug(function)
        # We need to recheck auth in here so we can pass in the id
        c.form = 'edit'
        c.comment  = Comment.find_by_id(id)

        if c.comment.user_id != c.user.id:
            abort(401)

        defaults = h.object_to_defaults(c.comment, 'comment')

        defaults['comment.place_id'] = c.comment.place_id

        form = render('/comments/edit.mako')
        return htmlfill.render(form, defaults)

    @validate(schema=UpdateCommentSchema(), form='edit', post_only=True, on_get=True, variable_decode=True)
    def _edit(self, id):
        ''' Update Place '''
        function = '_edit'
        log.debug(function)

        comment = Comment.find_by_id(id)
        if comment:
            comment.last_update = datetime.datetime.now()
            comment.title = self.prm('comment.title')
            comment.content = self.prm('comment.content')
            meta.Session.commit()

        h.flash(_(u'El comentario se ha actualizado correctamente'))
        redirect(h.url_for(controller='comments',action='detail', id=comment.id))

    def delete(self,id, place_id):
        ''' Borrar una muestra '''
        comment = Comment.find_by_id(id)

        if comment.user_id != c.user.id:
           abort(401)

        ##''' No lo borramos, solo actulizamos la fecha en deleted_on '''
        comment.remove()

        h.flash(_(u'Se ha borrado el comentario correctamente'))
        redirect(h.url_for(controller='places', action='detail', id=place_id))

