<%inherit file="/common.mako"/>
<%namespace name="functions"  file="/functions.mako"/>
<%namespace name="commons"  file="commons.mako"/>

<%def name="title()">${_(u'Editar Muestra')}</%def>

<%def name="head()">
    <link rel="stylesheet" type="text/css" href="/css/common.css" />

    <script type="text/javascript" src="/js/flowplayer-3.2.4.min.js"></script>
    <script type="text/javascript" src="/js/jquery.tagcloud.min.js" charset="utf-8"></script>
    <script type="text/javascript" src="/js/view.js" charset="utf-8"></script>

    <script type="text/javascript">

        function map_load() {

            // Acercamos el zoom lo mas cerca posible
            map.setCenter(new google.maps.LatLng(${c.place.latitude}, ${c.place.longitude}));
            map.setZoom(max_zoom);

            html =  '<table>' +
                '<tr><td><a class="cloud_strong">${_(u'lugar')}: </a></td>' +
                '<td><a class="estiloAzul" href="/view/place?id=${c.place.id}&latitude=${c.place.latitude}&longitude=${c.place.longitude}">' +
                '${c.place.name}</a>'+
                '</td></tr><tr><td>' + 
                '<a class="cloud_strong">${_(u'autor')}:</a></td><td>' +
                '<a class="cloud_header" href="/${c.place.user.nickname}">${c.place.user.nickname}</a></td></tr>' +
                '<tr><td><a class="cloud_strong">${_(u'modificado')}:</a></td>' +
                '<td><a class="cloud_strong">${c.place.last_update}</a></td>' +
                '<tr><td><a class="cloud_strong">${_(u'pH')}:</a></td>' +
                '<td><a class="cloud_sub">${c.place.ph}</a></td></tr>' +
                '<tr><td><a class="cloud_strong">${_(u'Cloro')}:</a></td>' +
                '<td><a class="cloud_sub">${c.place.chlorine}</a></td></tr></table>';

            var drop_marker = ${functions.GetDrop(c.place.ph, c.place.chlorine)};
            var marker = create_marker({
                position: new google.maps.LatLng(${c.place.latitude}, ${c.place.longitude}),
                icon: drop_marker,
                map: map
            }, infowindow, html);
        }
    </script>
</%def>

<%def name="title()">${_(u'Editar Muestra')}</%def>

<%def name="MainContent()">
    <div id="queMapa">


        <div align="right"><a href="/" class="close-icon"></a></div>

        <h2 class="mom">${_(u'Editar Muestra')}</h2>	    
        ${h.form(h.url_for(id=c.place.id)) }
        <%include file="form.mako" />

        ##<a class='accion bordeSoft' style='text-transform: uppercase:'  id='grande'>

        ${ h.submit('update', _(u'Actualizar'), class_='accion bordeSoft') }
            ##</a>

        ${ h.end_form() }
</div>
</%def>

<%def name="init()"></%def>

<%def name="content()">
    <h3>${_(u'Muestra de Agua Analizadas')}</h3>
    <div id="list"></div>
    <div id="srToolsDown"></div>
</%def>
