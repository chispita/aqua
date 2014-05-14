# -*- coding: utf-8 -*-
<%inherit file="../common.mako"/>
<%namespace name="functions"  file="/functions.mako"/>
<%namespace name="commons"  file="commons.mako"/>

<%def name="title()">${_(u'Recuperacion de Contraseña')}:</%def>

<%def name="head()">
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
        <h2>${_(u'Recuperar la contraseña')}</h2>
        <p>${_(u'Introduce tu dirección de correo y se te será enviado un correo con una nueva contraseña.')}</p>
        ${ h.form( h.url_for(), method='post') }
            <p class="label"><label for="email">${_(u'Email')}:</label>
                ${ h.text('email', size=30) }</p>                   
        <p class="submit">${ h.submit('submit', _(u'Recuperar contraseña'), class_='accion bordeSoft') }</p>
    </div>
</%def>

<%def name="content()">
    <h3>${_(u'Muestra de Agua Analizadas')}:</h3>
</%def>
