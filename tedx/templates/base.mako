# -*- coding: utf-8 -*-
<%inherit file="common.mako"/>
<%namespace name="functions"  file="functions.mako"/>
<%def name="title()">${next.title()}</%def>

<%def name="head()"></%def>

<%def name="javascript()">
    function map_load() {
        % for place in c.places_map :
                 html =  '<table>' +
                    '<tr><td><a class="cloud_strong">${_(u'Nombre')}:</a></td>' +
                    '<td><a class="estiloAzul" href="/places/${place.id}">${place.name}</a>'+
                    '</td></tr><tr><td>' + 
                    '<a class="cloud_strong">${_(u'Autor')}:</a></td><td>' +
                    '<a class="cloud_header" href="/account/${place.user.nickname}">${place.user.nickname}</a></td></tr>' +
                    '<tr><td><a class="cloud_strong">${_(u'Creada')}:</a></td>' +
                    '<td><a class="cloud_sub">${place.created_on.strftime('%H:%M-%d/%m/%y')}</a></td>' +
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
