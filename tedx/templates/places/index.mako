<%inherit file="../base.mako"/>
<%namespace name="functions"  file="/functions.mako"/>

<%def name="title()"> ${_(u'Home')}</%def>

<%def name="MainContent()">
    %if not c.user:
        <div id="queMapa">
            <h2>${_(u'Controla el agua que bebes')}</h2>
            <a class="text">
                ${_(u'Si hay algo que merece nuestra atención y cuidado, eso es el agua que bebemos todos los dias.')}
                </br></br>
                ${_(u'Tanto si vives en un pueblo aislado  o en una ciudad con tramos de tubería muy largos, queremos que nos ayudes a controlar si los niveles de cloro en nuestros grifos son  los adecuados para el consumo.')}
                </br></br>
                ${_(u' Aquí puedes compartir el resultado de analizar el agua de tu casa, o el de la fuente de tu parque, el que encuentre en tus viajes...')}
                ${_(u'¿Quieres subir tu propia medida de análisis?')}
            </a>
            </br></br></br>
            <div class="centerize">
                <a href='/signin' class='accion right bordeSoft' style='text-transform: uppercase:' id='grande'>
                ${_(u'Entrar')}</a>
            </div>
        </div>
     %endif
</%def>

<%def name="content()">
    <h3>${_(u'Muestras enviadas')}</h3>
    ${c.AllPlaces}
    ${functions.list_places(c.ListPlaces)}

    ${c.ListPlaces.pager('Page $page: $link_previous $link_next ~4~')}
</%def>
