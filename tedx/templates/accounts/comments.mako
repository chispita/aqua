# -*- coding: utf-8 -*-
<%inherit file="../common.mako"/>
<%namespace name="functions"  file="/functions.mako"/>
<%namespace name="commons"  file="commons.mako"/>

<%def name="title()">${_(u'Comentarios')}: ${c.nickname}</%def>

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
                        '<a class="cloud_header" href="/account/${place.user.nickname}">${place.user.nickname}</a></td></tr>' +
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
    <div class="sidebarIzq">
        <%include file="../information/teachers.mako"/>
    </div>

    <a name="muestras">    
    <div class="content_center">
        <h3>${_(u'Comentarios realizados')} ${_(u'por')}: ${c.nickname}</h3>
        ${functions.list_comments(c.Comments)}
        ${c.Comments.pager('Page $page: $link_previous $link_next ~4~')}
    </div>
    </a>
                                                                    
    <div class="sidebarDer">
        <%include file="../information/datos.mako"/>
    </div>
</%def>
