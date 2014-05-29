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
    <h3>${_(u'Comentarios')}</h3>

    %if not c.user:
        </br>
        <a class="text">${_(u'Debes de estar logeado para poder escribir comentarios')}</a>
    %else:
        </br>
        <div class="centerize">

            <a href="/places/${c.place.id}/comments/new" class="accion bordeSoft" id="new-instant-btnSend">${_(u'Añadir comentario')}</a>
        </div>
    %endif

    ${functions.list_comments(c.ListComments)}
    </br>
    ${c.ListComments.pager(
        link_attr = {'class':'accion bordeSoft'},
        curpage_attr = {'class': 'seleccion bordeSoft'},
        dotdot_attr = {'class': 'accion bordeSoft'})}
</%def>
