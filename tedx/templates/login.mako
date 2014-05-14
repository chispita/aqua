# -*- coding: utf-8 -*-
<%inherit file="common.mako"/>
<%def name="title()">${_(u'register')}</%def>

<%def name="head()">
</%def>

<%def name="init()"></%def>

<%def name="content()"></%def>
<%def name="MainContent()">

    <div id="queMapa">

        <div align="right"><a href="/" class="close-icon"></a></div>

        <h2>${_(u'Inicio de sesion')}</h2>

        <form id="form1" method="post" action="/common/login" >

            <label for="new-session-txtName">${_(u'Email')}:<br />
                <input type="text"  name="login_email" id="login_email"></input>
            </label><br/>

            <label for="new-session-txtPassword">${_(u'Password')}:<br />
                <input type="password" name="login_password" id="login_password" onkeydown="if ((event.which && event.which == 13) || (event.keyCode && event.keyCode == 13)) {login();}"></input>
            </label><br/>
            </br></br>
            <div class="centerize">
                <a href="javascript:void(0);" onclick="login();" class="accion bordeSoft">${_(u'Entrar')}</a>
                <a href="/register" class="accion bordeSoft" id="new-instant-btnSend">${_(u'Registrarse')}</a>
            </div>

            </br></br>

            <div class="centerize">
                <a href="/forgotpassword">${_(u'Recuperar contraseña')}</a>
            </div
        </form>

        <div class="clear"></div>
        </div>
</%def>



<%def name="content()">
    <h3>${_(u'Muestra de Agua Analizadas')}</h3>
    <div id="list"></div>
    <div id="srToolsDown"></div>
</%def>
