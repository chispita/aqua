# -*- coding: utf-8 -*-
<%inherit file="../common.mako"/>
<%namespace name="functions"  file="/functions.mako"/>
<%namespace name="commons"  file="commons.mako"/>
<%def name="title()">${next.title()}</%def>

<%def name="head()">
    <link rel="stylesheet" type="text/css" href="/css/common.css" />

    <script type="text/javascript" src="/js/flowplayer-3.2.4.min.js"></script>
    <script type="text/javascript" src="/js/jquery.tagcloud.min.js" charset="utf-8"></script>
    <script type="text/javascript" src="/js/view.js" charset="utf-8"></script>
    <script type="text/javascript">

        function map_load() {
            // Acercamos el zoom lo mas cerca posible

            ##% if c.MapPlace:
                /*
                map.setCenter(new google.maps.LatLng(${c.MapPlace.latitude}, ${c.MapPlace.longitude}));
                map.setZoom(max_zoom);

                    
                    html =  '<table>' +
                    '<tr><td><a class="cloud_strong">${_(u'lugar')}:</a></td>' +
                        '<td><a class="estiloAzul" href="/places/${MapPlace.id}">${MapPlace.name}</a>'+
                    '</td></tr><tr><td>' + 
                    '<a class="cloud_strong">${_(u'autor')}:</a></td><td>' +
                    '<a class="cloud_header" href="/account/${MapPlace.user.nickname}">${MapPlace.user.nickname}</a></td></tr>' +
                    '<tr><td><a class="cloud_strong">${_(u'modificado')}:</a></td>' +
                    '<td><a class="cloud_strong">${MapPlace.last_update}</a></td>' +
                    '<tr><td><a class="cloud_strong">${_(u'pH')}:</a></td>' +
                    '<td><a class="cloud_sub">${MapPlace.ph}</a></td></tr>' +
                    '<tr><td><a class="cloud_strong">${_(u'Cloro')}:</a></td>' +
                    '<td><a class="cloud_sub">${MapPlace.chlorine}</a></td></tr></table>';

                    var drop_marker = ${functions.GetDrop(MapPlace.ph, MapPlace.chlorine)};
                    var marker = create_marker({
                        position: new google.maps.LatLng(${MapPlace.latitude}, ${MapPlace.longitude}),
                        icon: drop_marker,
                        map: map
                    }, infowindow, html);
                */

                ##% elif c.MapPlaces:

                % for place in c.MapPlaces :
                    /*
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
                    */
                % endfor

                ##%endif
            }
    </script>
</%def>

<%def name="init()"></%def>

<%def name="extra_body()">
    <body onload="map_load()">
</%def>

<%def name="MainContent()">
    ${next.MainContent()}
</%def>

<%def name="content()">
    ${next.content()}
</%def>
