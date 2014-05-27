# -*- coding: utf-8 -*-
<%inherit file="common.mako"/>
<%namespace name="functions"  file="functions.mako"/>
<%def name="title()">${next.title()}</%def>

<%def name="head()">
</%def>

<%def name="javascript()">
    function map_load() {
        // Acercamos el zoom lo mas cerca posible
        map.setCenter(new google.maps.LatLng(${c.place.latitude}, ${c.place.longitude}));
        map.setZoom(max_zoom);

        html =  '<table>' +
            '<tr><td><a class="cloud_strong">${_(u'lugar')}:</a></td>' +
            '<td><a class="estiloAzul" href="/places/${c.place.id}">${c.place.name}</a>'+
            '</td></tr><tr><td>' + 
            '<a class="cloud_strong">${_(u'autor')}:</a></td><td>' +
            '<a class="cloud_header" href="/account/${c.place.user.nickname}">${c.place.user.nickname}</a></td></tr>' +
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

        % for place in c.places_map :
                console.log('pinto');
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
