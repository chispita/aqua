## cabecera.mako ##
<div id="contenedor">
    <div id="cabecera">
        <div id="idioma" style="margin-top: 10px;">
            <a href="javascript: change_language('es')">Español</a> / <a href="javascript: change_language('en')">English</a>
        </div>

        <div id="logotipo" style="float:left; margin">
            <a href="/"><img src="/images/logo-web-fondo-transparente.png" alt="Logo Tedx"  /></a>
        </div>

        %if not c.user:
            <div id="login" class="right">
                <form id="form1" method="post" action="/common/form_login" >
                    <div id="logLeft" class="bordeHalf">
                        <div for="usuario" >${_(u'usuario / email')}</div>
                        <input type="text"  name="login_email" id="login_email"></input>
                        <div for="password" >${_(u'password')}</div>
                        <input type="password" name="login_password" id="login_password" onkeydown="if ((event.which && event.which == 13) || (event.keyCode && event.keyCode == 13)) {$('#form1').submit();}"></input>
                            <a href="javascript: forgot_password();" id="lost" class="left">${_('forgotten_password')}</a>
                            <a href="#" onclick="$('#form1').submit();" style="text-transform: uppercase;" class="accion right bordeSoft">${_(u'log_in')}</a>
                    </div>
                    <div id="logRight">
                        <p>${_(u'login_question')}</p>
                        <a href="javascript:register_user();" class="registro left bordeSoft" style="text-transform: uppercase;">${_(u'register')}</a>
                    </div>
                </form>
            </div>
        % else:
             <div id="login" class="right">
                <div id="logLeft" class="bordeHalf">
                    <h2>${_(u'hello')} <a href="/my_account"><span class="username">${c.user.nickname}</span></a>!</h2>
                    <span class="logOut"><a href="javascript:logout();">Salir</a></span>
                </div>
                <img src="${c.user.avatar}_mid.png" width=136 height=136 alt=${c.user.nickname} />
            </div>
        %endif
	    <div id="MenuTop">
	</div>
</div>
