# -*- coding: utf-8 -*-
<%inherit file="../common.mako"/>
<%def name="title()">
    ${_(u'No tienes autorización')}
</%def>

<%def name="head()">
    <link rel="stylesheet" type="text/css" href="/css/my_account.css" />

</%def>
<%def name="init()"></%def>


<%def name="MainContent()">

    <div id="MsgOverMap">

        <div align="right"><a href="/" class="close-icon"></a></div>

        <h2>${_(u'No estas autorizado para acceder a esta URL!')}</h3>
        <br>
        ${ _(u'No estas autorizado para acceder a la URL seleccionada.')}
        <br></br>


        <div class="centerize">
            <a class="left accion bordeSoft"  href="/home"  id="print_Stickers_button">${_(u'Volver')}</a>
        </div>
    </div>

</%def>  
                
<%def name="content()">
    <h3>${_(u'Muestra de Agua Analizadas')}</h3>
    <div id="list"></div>
    <div id="srToolsDown"></div>
</%def>
<%def name="contentIzd()">



