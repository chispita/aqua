# -*- coding: utf-8 -*-
<%inherit file="../base.mako"/>

<%namespace name="functions"  file="/functions.mako"/>
<%namespace name="commons"  file="commons.mako"/>

<%def name="title()">${_(u'Comentarios')}: ${c.nickname}</%def>

<%def name="MainContent()">

    <div id="queMapa">
        <h2>${_(u'Comentarios realizados')}</h2>
    </div>
</%def>

<%def name="content()">
    <a name="muestras"/>    
    <h3>${_(u'Comentarios realizados')} ${_(u'por')}: ${c.nickname}</h3>
    ${functions.list_comments(c.Comments)}

    </br>
    ${c.Comments.pager(
        link_attr = {'class':'accion bordeSoft'},
        curpage_attr = {'class': 'seleccion bordeSoft'},
        dotdot_attr = {'class': 'accion bordeSoft'})}
</%def>
