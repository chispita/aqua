# -*- coding: utf-8 -*-
<%inherit file="../base.mako"/>
<%namespace name="functions"  file="/functions.mako"/>
<%namespace name="commons"  file="commons.mako"/>

<%def name="title()">${_(u'Usuario')}:</%def>


<%def name="content()"></%def>
<%def name="MainContent()">
    <div id="queMapa">
        ${commons.show_user(c.user_search, False)}
    </div>
</%def>

<%def name="content()">
    <h3>${_(u'Muestra de Agua Analizadas')}:</h3>
    ${functions.list_places(c.places)}
    ${c.places.pager('Page $page: $link_previous $link_next ~4~')}
</%def>
