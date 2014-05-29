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
    </br>
    ${c.places.pager(
        link_attr = {'class':'accion bordeSoft'},
        curpage_attr = {'class': 'seleccion bordeSoft'},
        dotdot_attr = {'class': 'accion bordeSoft'})}
</%def>
