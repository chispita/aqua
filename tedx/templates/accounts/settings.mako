# -*- coding: utf-8 -*-
<%inherit file="../base.mako"/>
<%namespace name="functions"  file="/functions.mako"/>

<%def name="title()">
    ${_(u'Configuración')}
</%def>


<%def name="init()"></%def>

<%def name="MainContent()">
    <div id="queMapa">
        <div align="right"><a href="/" class="close-icon"></a></div>
        <h2>${_(u'Actualiza tu perfíl')}</h2>
        ${ h.form(url=h.url_for(id=c.user.id)) }
            <a class="text">${_(u'Nombre')}</a></br>
            ${ h.text('register.name', size=50) }

            <a class="text">${_(u'Email')}</a></br>
            ${ h.text('register.email', size=50) }

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

