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

        page = 1

        return render('/comments/index.mako')

    def detail(self, id, place_id):
        function = 'detail'
        log.debug(function)

        c.comment  = meta.Session.query(Comment).filter_by(id=id).first()

        if c.comment is None:
            abort(404)

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

        place  = meta.Session.query(Place).filter_by(id=place_id).first()

        if place is None:
            abort(404)

        #Podemos poner valores por defecto
        defaults = {
            'comment.place_id': place.id,
            }

        form = render('/comments/new.mako')
        return htmlfill.render(form, defaults)

    @validate(schema=NewCommentSchema(), form='new', post_only=True, on_get=True, variable_decode=True)
    def _new(self):
        function = '_new'
        log.debug(function)

        # Recuperamos los datos
        place_id = self.prm('comment.place_id')
        title = self.prm('comment.title')
        content = self.prm('comment.content')

        image = request.params.get('comment.image')

        log.debug('%s image:%s' % (function, str(image)))

        place  = meta.Session.query(Place).filter_by(id=place_id).first()

        # Grabar todos los datos
        db_comment = place.add_comment(c.user, content, title)

        # Grabacion de la imagen
        if (image != None and image != ""):
            UploadFile( db_comment, image)

        h.flash(_(u'El comentario se ha grabado correctamente'))
        redirect(h.url_for(controller='places', action='detail', id=place_id))

    @dispatch_on(POST="_edit")
    def edit(self, id, place_id):
        function = 'edit'
        log.debug(function)
        # We need to recheck auth in here so we can pass in the id
        '''
        if not h.auth.authorized(h.auth.Or(h.auth.is_same_zkpylons_user(id), h.auth.has_organiser_role)):
            # Raise a no_auth error
            h.auth.no_role()
        '''
        c.form = 'edit'
        c.comment  = meta.Session.query(Comment).filter_by(id=id).first()
        if not c.comment:
            abort(404)

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

            # Raise a no_auth error
            # h.auth.no_role()

        #c.person = Person.find_by_id(id)
        #self.finish_edit(c.person)

        comment  = meta.Session.query(Comment).filter_by(id=id).first()
        if comment:
            comment.last_update = datetime.datetime.now()
            comment.title = self.prm('comment.title')
            comment.content = self.prm('comment.content')
            meta.Session.commit()

        h.flash(_(u'El comentario se ha actualizado correctamente'))
        redirect(h.url_for(controller='comments',action='detail', id=comment.id))

    def delete(self,id, place_id):
        ''' Borrar una muestra '''

        comment  = meta.Session.query(Comment).filter_by(id=id).first()

        if not comment:
            abort(404)

        if comment.user_id != c.user.id:
           abort(401)

        ##''' No lo borramos, solo actulizamos la fecha en deleted_on '''
        comment.remove()

        h.flash(_(u'Se ha borrado el comentario correctamente'))
        redirect(h.url_for(controller='places', action='detail', id=place_id))


