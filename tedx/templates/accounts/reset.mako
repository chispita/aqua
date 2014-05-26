# -*- coding: utf-8 -*-
<%inherit file="../base.mako"/>
<%namespace name="functions"  file="/functions.mako"/>

<%def name="title()">
    ${_(u'Cambiar contraseña')}
</%def>

<%def name="MainContent()">
    <div id="queMapa">
        <div align="right"><a href="/" class="close-icon"></a></div>
        <h2>${_(u'Cambia tu contraseña')}</h2>
        ${ h.form(url=h.url_for(id=c.user.id)) }
            <a class="text">${_(u'Nueva Contraseña')}</a></br>
            ${ h.password("reset.password1", size=15) }</p>

            <a class="text">${_(u'Repita la contraseña')}</a></br>
            ${ h.password("reset.password2", size=15) }</p>

            </br></br>
            <div class="centerize">
                <p class="submit">${ h.submit('submit', _(u'Guardar los cambios'), class_='accion bordeSoft') }</p>
            </div>
        ${ h.end_form() }
    </div>
</%def>  
                
<%def name="content()">
    <h3>${_(u'Muestra de Agua Analizadas')}</h3>
    ${functions.list_places(c.places)}
    ${c.places.pager('Page $page: $link_previous $link_next ~4~')}
</%def>

