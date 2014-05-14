# -*- coding: utf-8 -*-
<%inherit file="../common.mako"/>
<%namespace name="functions"  file="/functions.mako"/>
<%namespace name="commons"  file="commons.mako"/>

<%def name="title()">${_(u'Usuario')}:</%def>

<%def name="head()">
    <script type="text/javascript" src="/js/my_account.js">
    </script>

    <script type="text/javascript">
        function map_load() {
            // Acercamos el zoom lo mas cerca posible
            % for place in c.places_map :

                html =  '<table>' +
                        '<tr><td colspan="2">' +
                        '<a class="estiloAzul" href="/places/${place.id}">${place.name}</a>'+
                        '</td></tr><tr><td>' + 
                        '<a class="cloud_strong">${_(u'author')}:</a></td><td>' +
                        '${place.user.nickname}</td></tr>' +
                        '<tr><td><a class="cloud_strong">${_(u'last_update')}:</a></td>' +
                        '<td><a class="cloud_strong">${place.last_update}</a></td>' +
                        '<tr><td><a class="cloud_strong">${_(u'pH')}:</a></td>' +
                        '<td><a class="cloud_sub">${place.ph}</a></td></tr>' +
                        '<tr><td><a class="cloud_strong">${_(u'Chlorine')}:</a></td>' +
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

<%def name="content()"></%def>
<%def name="MainContent()">

    <div id="queMapa">
        ${commons.show_user(c.user_search)}
    </div>
</%def>

<%def name="content()">
    <h3>${_(u'Muestra de Agua Analizadas')}:</h3>
    ${functions.list_places(c.places)}
    ${c.places.pager('Page $page: $link_previous $link_next ~4~')}
</%def>
