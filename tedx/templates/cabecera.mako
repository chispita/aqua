## cabecera.mako ##
<div id="contenedor">
    <div id="cabecera">
        <div id="logotipo" style="float:left; margin; border-style:solid;border-color:#0000ff;">
            <a href="/"><img src="/images/aguagrifo.png" alt="aqua ibercivis"  /></a>
        </div>

        <div id="barra_login">
            %if c.user:
                ${_(u'Hola')} <a href="/account/profile/">${c.user.nickname}</a>!
                <a href="javascript:logout();" class="logolink" >${_(u'Salir')}</a>
            %else:
                <a href="/signin" class="logolink">${_(u'Entrar')}</a> |
                <a href="/register_new" class="logolink">${_(u'Registrarse')}</a>
            %endif:
            &nbsp;
            <a href="javascript: change_language('es')"><img src="/images/es.png"></a>
            <a href="javascript: change_language('en')"><img src="/images/en.png"></a>

            <a href="/information" class="logolink">${_(u'Info')}</a>
        </div>
        <div id="MenuTop">
	</div>
</div>
