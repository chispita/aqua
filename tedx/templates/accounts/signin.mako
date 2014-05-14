# -*- coding: utf-8 -*-
<%inherit file="../common.mako"/>
<%namespace name="functions"  file="/functions.mako"/>
<%namespace name="commons"  file="commons.mako"/>

<%def name="title()">${_(u'Usuario')}:</%def>

<%def name="head()">
    <script type="text/javascript" src="/js/my_account.js">
    </script>
</%def>

<%def name="init()"></%def>

<%def name="extra_body()">
    <body onload="map_load()">
</%def>

<%def name="content()"></%def>
<%def name="MainContent()">

    <div id="queMapa">
        <div align="right"><a href="/" class="close-icon"></a></div>
        <h2>${_(u'Entar')}</h2>
        ${ h.form(h.url_for(), method='post') }
        <p class="label"><label for="person.email_address">${_(u'Email')}:</label></p>
        <p class="entries">${ h.text('person.email', size=30) }</p>
                   
        <p class="label"><label for="person.password">${_(u'Contraseña')}</label></p>
        <p class="entries">${ h.password('person.password') }</p>
                             
        <p class="submit">${ h.submit('Sign in', 'Entrar', class_='accion bordeSoft') }</p>
        ${ h.end_form() }

        <a href="/forgotten_password" class="logolink">${_(u'Recuperar la contraseña')}</a>

    </div>
</%def>

<%def name="content()">
    <h3>${_(u'Muestra de Agua Analizadas')}:</h3>
</%def>
