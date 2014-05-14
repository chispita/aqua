<%inherit file="common.mako"/>
<%namespace name="functions"  file="/functions.mako"/>

<%def name="title()"> ${_(u'Home')}</%def>

<%def name="head()">
    <script type="text/javascript">
        function map_load() {
            // Acercamos el zoom lo mas cerca posible
            % for place in c.AllPlaces :
                html =  '<table>' +
                    '<tr><td><a class="cloud_strong">${_(u'lugar')}:</a></td>' +
                    '<td><a class="estiloAzul" href="/places/${place.id}">${place.name}</a>'+
                    '</td></tr><tr><td>' + 
                    '<a class="cloud_strong">${_(u'autor')}:</a></td><td>' +
                    '<a class="cloud_header" href="/account/${place.user.nickname}">${place.user.nickname}</a></td></tr>' +
                    '<tr><td><a class="cloud_strong">${_(u'modificado')}:</a></td>' +
                    '<td><a class="cloud_strong">${place.last_update}</a></td>' +
                    '<tr><td><a class="cloud_strong">${_(u'pH')}:</a></td>' +
                    '<td><a class="cloud_sub">${place.ph}</a></td></tr>' +
                    '<tr><td><a class="cloud_strong">${_(u'Cloro')}:</a></td>' +
                    '<td><a class="cloud_sub">${place.chlorine}</a></td></tr></table>';

                var drop_marker = ${functions.GetDrop(place.ph, place.chlorine)};
                var marker = create_marker({
                    position: new google.maps.LatLng(${place.latitude}, ${place.longitude}),
                    icon: drop_marker,
                    map: map
                }, infowindow, html);
            % endfor
        }
    </script>
</%def>


<%def name="init()"></%def>

<%def name="extra_body()">
    <body onload="map_load()">
</%def>


<%def name="MainContent()">

    %if not c.user:

        <div id="queMapa">
            <h2>${_(u'Controla el agua que bebes')}</h2>
            
            <p>${_(u'Si hay algo que merece nuestra atención y cuidado, eso es el agua que bebemos todos los dias.')}</p>
            <p>${_(u'Tanto si vives en un pueblo aislado  o en una ciudad con tramos de tubería muy largos, queremos que nos ayudes a controlar si los niveles de cloro en nuestros grifos son  los adecuados para el consumo.')}</p>
            <p>${_(u' Aquí puedes compartir el resultado de analizar el agua de tu casa, o el de la fuente de tu parque, el que encuentre en tus viajes...')}</p>
            <p>${_(u'¿Quieres subir tu propia medida de análisis?')}</p>

            <br><br>
            <div class="centerize">
                <a href='/signin' class='accion right bordeSoft' style='text-transform: uppercase:' id='grande'>
                ${_(u'Entrar')}</a>
            </div>
        </div>
     %endif
</%def>

<%def name="content()">
    <div class="sidebarIzq">
        <%include file="information/teachers.mako"/>
    </div>

    <div class="content_center">
        <h3>${_(u'Ultimas muestras enviadas')}</h3>

        ${functions.list_places(c.LastPlaces)}

        ${c.LastPlaces.pager('Page $page: $link_previous $link_next ~4~')}
    </div>
                                                                    
    <div class="sidebarDer">
        <%include file="information/datos.mako"/>
    </div>
</%def>
