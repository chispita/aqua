# -*- coding: utf-8 -*-
<%inherit file="../base.mako"/>
<%namespace name="functions"  file="/functions.mako"/>

<%def name="title()">
    ${_(u'Usuarios Registrados')}
</%def>

<%def name="MainContent()">
    <div  id="queMapa">
        <div align="right"><a href="/" class="close-icon"></a></div>
        <h2>${_(u'Usuarios más activos')}</h2>
        <% counter = 0 %>
        %for place in c.TopUser:
            <% counter +=1 %>
            <a class="text">${counter} - </a>
            <a class="text" href="${place[0].user.nickname}"> ${ place[0].user.nickname }</a>
            <a class="text">(${place[1]})</a>
            </br>
        %endfor
    </div>
</%def>  
                
<%def name="content()">
    <h3>${_(u'Usuarios Registrados')}</h3>
    ${functions.list_users(c.Users)}
    </br>
    ${c.Users.pager(
        link_attr = {'class':'accion bordeSoft'},
        curpage_attr = {'class': 'seleccion bordeSoft'},
        dotdot_attr = {'class': 'accion bordeSoft'})}
</%def>

