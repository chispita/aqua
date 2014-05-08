# -*- coding: utf-8 -*-
<%inherit file="../common.mako"/>
<%def name="title()">
    ${_(u'Prohibido')}
</%def>

<%def name="head()">
    <link rel="stylesheet" type="text/css" href="/css/my_account.css" />

</%def>
<%def name="init()"></%def>


<%def name="MainContent()">

    <div id="MsgOverMap">

        <div align="right"><a href="/" class="close-icon"></a></div>

        <h2>${_(u'Prohibido')}</h3>
        <br>
        ${ _(u'Lo sentimos pero no tienes permiso para acceder a esta página')}
        <br></br>


        <div class="centerize">
            <a class="left accion bordeSoft"  href="/home"  id="print_Stickers_button">${_(u'Volver')}</a>
        </div>
    </div>

</%def>  
                
<%def name="content()">
    <div class="sidebarIzq">
        <%include file="..//information/teachers.mako"/>
    </div>
                                                                  
    <div class="content_center">
        <h3>${_(u'Muestra de Agua Analizadas')}</h3>
        <div id="list"></div>
            <div id="srToolsDown"></div>
        </div>
                                                                    
        <div class="sidebarDer">
            <%include file="../information/datos.mako"/>
        </div>
</%def>

