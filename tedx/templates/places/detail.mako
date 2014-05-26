# -*- coding: utf-8 -*-
<%inherit file="../base_single.mako"/>
<%namespace name="functions"  file="/functions.mako"/>
<%namespace name="commons"  file="commons.mako"/>
<%def name="title()">${_(u'Detalle Muestra')}</%def>

<%def name="MainContent()">
    <div id="queMapa">
        ${commons.show_place(c.place)}
    </div>
</%def>

<%def name="content()">
    <h3>${_(u'Comentarios')}</h>

    %if not c.user:
        ${_(u'login_first_to_comment')} <!-- Para hacer un comentario hace falta hacer login primero -->
    %else:
        <div class="centerize">
            <a href="/places/${c.place.id}/comments/new" class="accion bordeSoft" id="new-instant-btnSend">${_(u'Añadir comentario')}</a>
        </div>
    %endif

    ${functions.list_comments(c.ListComments)}
    ${c.ListComments.pager('Page $page: $link_previous $link_next ~4~')}
</%def>
