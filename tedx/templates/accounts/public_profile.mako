# -*- coding: utf-8 -*-
<%inherit file="../base.mako"/>
<%namespace name="functions"  file="/functions.mako"/>
<%namespace name="commons"  file="commons.mako"/>

<%def name="title()">${_(u'Usuario')}: ${c.nickname}</%def>

<%def name="MainContent()">
    <div id="queMapa">
        ${commons.show_user(c.user_search, True)}
    </div>
</%def>

<%def name="content()">
    <a name="muestras"></a>
        <h3>${_(u'Muestra de Agua Analizadas')} ${_(u'por')}: ${c.nickname}</h3>
        ${functions.list_places(c.places)}
        ${c.places.pager('Page $page: $link_previous $link_next ~4~')}
    </a>
</%def>
