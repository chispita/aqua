# -*- coding: utf-8 -*-
<%inherit file="../base.mako"/>
<%namespace name="functions"  file="/functions.mako"/>
<%namespace name="commons"  file="commons.mako"/>

<%def name="title()">${_(u'Usuario')}:</%def>

<%def name="MainContent()">

    <div id="queMapa">
        <div align="right"><a href="/" class="close-icon"></a></div>

        <h2>${_(u'Entrar')}</h2>
        ${ h.form(h.url_for(), method='post') }
            <a class="text">${_(u'Email')}</a></br>
            ${ h.text('person.email', size=30) }</br>
                   
            <a class="text">${_(u'Contraseña')}</a></br>
            ${ h.password('person.password') }</br>

            </br></br>
            <div class="centerize">
                <p class="submit">${ h.submit('Sign in', 'Entrar', class_='accion bordeSoft') }</p>
            </div>
        ${ h.end_form() }

        <br>
        <a class="text">${_(u'Si no recuerdas tu contraseña puede solictar una nueva')}</a></br>

        </br></br>
        <div class="centerize">
            <a href="/forgotten_password" class="accion bordeSoft">${_(u'Recuperar la contraseña')}</a>
        </div>

    </div>
</%def>

<%def name="content()">
    <h3>${_(u'Muestra de Agua Analizadas')}:</h3>
    ${functions.list_places(c.places)}
    ##${c.places.pager('Page $page: $link_previous $link_next ~4~')}
</%def>
