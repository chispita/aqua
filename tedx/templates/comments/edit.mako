<%inherit file="../base.mako"/>
<%namespace name="functions"  file="/functions.mako"/>
<%namespace name="commons"  file="commons.mako"/>

<%def name="title()">${_(u'Editar Comentario')}</%def>

<%def name="MainContent()">
    <div id="queMapa">
        <div align="right"><a href="/" class="close-icon"></a></div>
        <h2>${_(u'Editar Comentario')}</h2>	    
        ${h.form(h.url_for(id=c.comment.id,place_id=c.comment.place_id))}
        <%include file="form.mako" />
            </br></br>
            <div class="centerize">
                <p class="submit">${ h.submit('submit', _(u'Enviar'), class_='accion bordeSoft') }</p>
            </div>
        ${ h.end_form() }
    </div>
</%def>

<%def name="init()"></%def>

<%def name="content()">
    <h3>${_(u'Muestra de Agua Analizadas')}</h3>
    <div id="list"></div>
    <div id="srToolsDown"></div>
</%def>
