# -*- coding: utf-8 -*-
<%inherit file="../base_single.mako"/>
<%namespace name="functions"  file="/functions.mako"/>
<%namespace name="commons"  file="commons.mako"/>
<%def name="title()">${_(u'Editar Muestra')}</%def>

<%def name="MainContent()">
    <div id="queMapa">
        <div align="right"><a href="/" class="close-icon"></a></div>

        <h2 class="mom">${_(u'Editar Muestra')}</h2>    
        ${h.form(h.url_for(id=c.place.id)) }
            <%include file="form.mako" />
            <div class="centerize">
                <p class="submit">${ h.submit('update', _(u'Actualizar'), class_='accion bordeSoft') }</p>
            </div>
        ${ h.end_form() }
        </div>
</%def>

<%def name="content()">
    <% counter = 0 %>
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
