<%inherit file="../base.mako"/>

<%def name="title()">${_(u'Nueva Muestra')}</%def>

<%def name="MainContent()">
    <div id="queMapa">

        <div align="right"><a href="/" class="close-icon"></a></div>
        <h2 class="mom">${_(u'Nueva Muestra')}</h2>	    
        ${ h.form(url=h.url_for(), multipart=True) }
            <%include file="form.mako" />
            <div class="centerize">
                <p class="submit">${ h.submit('submit', _(u'Enviar'), class_='accion bordeSoft') }</p>
            </div>
        ${ h.end_form() }
    </div>
</%def>

<%def name="init()"></%def>

<%def name="content()">
    <h3>${_(u'Muestra de Agua Analizadas')}</h3>
</%def>
