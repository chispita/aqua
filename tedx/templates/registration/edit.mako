# -*- coding: utf-8 -*-
<%inherit file="../common.mako"/>
<%def name="title()">${_(u'Editar')}</%def>

<%def name="head()"></%def>

<%def name="init()"></%def>

<%def name="content()"></%def>
<%def name="MainContent()">

    <div id="queMapa">
        <div align="right"><a href="/" class="close-icon"></a></div>
        <h2>${_(u'Configuración')}</h2>

        ##${ h.form(url=h.url_for()) }
        ##    <%include file="form.mako" />
        ##    ${ h.submit('submit', _(u'Registrar'), class_='accion bordeSoft') }
        ##${ h.end_form() }

        <div class="clear"></div>
        </div>
    </%def>

<%def name="content()">
    <h3>${_(u'Muestra de Agua Analizadas')}</h3>
    <div id="list"></div>
    <div id="srToolsDown"></div>
</%def>
