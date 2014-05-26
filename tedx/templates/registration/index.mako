# -*- coding: utf-8 -*-
<%inherit file="../base.mako"/>
<%def name="title()">${_(u'Registro')}</%def>


<%def name="MainContent()">

    <div id="queMapa">
        <div align="right"><a href="/" class="close-icon"></a></div>

        <h2>${_(u'Registro')}</h2>
        ${ h.form(url=h.url_for()) }
        <%include file="form.mako" />

        </br></br>
        </br></br>
        <div class="centerize">
            ${ h.submit('submit', _(u'Registrar'), class_='accion bordeSoft grande') }
        </div>
        ${ h.end_form() }
    </div>
    </%def>

<%def name="content()">
    <h3>${_(u'Muestra de Agua Analizadas')}</h3>
</%def>
