# -*- coding: utf-8 -*-
<%inherit file="../base.mako"/>
<%namespace name="functions"  file="/functions.mako"/>
<%namespace name="commons"  file="commons.mako"/>
<%def name="title()">${_(u'View Comment')}</%def>

<%def name="MainContent()">
    <div id="queMapa">
        ${commons.show_comment(c.comment)}
    </div>
</%def>


<%def name="content()">
        <h3>${_(u'Comentarios')}</h>

        %if not c.user:
            ${_(u'login_first_to_comment')} <!-- Para hacer un comentario hace falta hacer login primero -->
        %else:

        %endif
</%def>
