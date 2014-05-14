# -*- coding: utf-8 -*-
<%inherit file="common.mako"/>
<%def name="title()">${_(u'register')}</%def>

<%def name="head()"></%def>

<%def name="init()"></%def>

<%def name="content()"></%def>
<%def name="MainContent()">

    <div id="queMapa">
        <div align="right"><a href="/" class="close-icon"></a></div>

        <h2>${_(u'Formulario de Registro')}</h2>
        <h3>old</h3>
        <form id="new-session-form" method="post" action="/register/save" >
            <label for="new-session-txtName">${_(u'Nombre')}:<br />
                <input type="text"  name="nickname" maxlength="32" placeholder="${_(u'nombre')}"> </input>
            </label><br/>
            <label for="new-session-txtEmail">${_(u'Email')}:<br />
                <input type="text" name="email"  maxlength="256" placeholder="${_(u'email')}"> </input>
            </label><br/>
            <label for="new-session-txtPassword">${_(u'Contraseña')}:<br />
                <input type="password"  name="password"  maxlength="32"></input>
            </label><br/>
            <label for="new-session-txtPassword">${_(u'Repite la Contraseña')}:<br />
                <input type="password" name="password2" maxlength="32"></input>
            </label><br/>
        </form>

        <br><br>
        <div class="centerize">
            <a href="javascript: new_session();" class="accion bordeSoft" id="new-instant-btnSend">${_(u'Aceptar')}</a>
        </div>

        <div class="clear"></div>
        </div>
    </%def>

<%def name="content()">
    <h3>${_(u'Muestra de Agua Analizadas')}</h3>
    <div id="list"></div>
    <div id="srToolsDown"></div>
</%def>
