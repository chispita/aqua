# -*- coding: utf-8 -*-
<%inherit file="common.mako"/>
<%def name="title()">${_(u'register')}</%def>

<%def name="head()"></%def>

<%def name="init()"></%def>

<%def name="content()"></%def>
<%def name="MainContent()">

    <div id="queMapa">

        <div align="right"><a href="/" class="close-icon"></a></div>

        <h2>${_(u'Recuperar contraseña')}</h2>
        <form id="forgot-password" method="post" action="/common/forgotten_password">

            <p>${_(u'Introduce el email con el que te registraste y te enviaremos tu nueva contraseña allí.')}</p>
            <label for="new-session-txtEmail">${_(u'Email')}:<br />
            <input type="text" name="email" id="email"></input>
            </label><br/>
            <br><br>
            <div class="centerize">
                <a href="javascript:void(0);" onclick="forgotten_password();" class="accion right bordeSoft">${_(u'Enviar')}</a>
            </div>
        </form>

        <div class="clear"></div>
    </div>
    </%def>

<%def name="content()">
    <h3>${_(u'Muestra de Agua Analizadas')}</h3>
    <div id="list"></div>
    <div id="srToolsDown"></div>
</%def>
