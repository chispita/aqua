# -*- coding: utf-8 -*-
<%inherit file="../common.mako"/>
<%namespace name="functions"  file="/functions.mako"/>
<%namespace name="commons"  file="commons.mako"/>
<%def name="title()">${_(u'view_place')}</%def>

<%def name="head()">
    <link rel="stylesheet" type="text/css" href="/css/common.css" />

    <script type="text/javascript" src="/js/flowplayer-3.2.4.min.js"></script>
    <script type="text/javascript" src="/js/jquery.tagcloud.min.js" charset="utf-8"></script>
    <script type="text/javascript" src="/js/view.js" charset="utf-8"></script>
    <script type="text/javascript">

        var user_id;
        var place_id;
        % if c.user:
            user_id = "${c.user.id}"
        % endif

        % if c.place.id:
            place_id = "${c.place.id}";
        % endif

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

<%def name="extra_body()">
    <body onload="map_load()">
</%def>

<%def name="init()">
</%def>
<%def name="MainContent()">
    <div id="queMapa">
        ${commons.show_place(c.place)}
    </div>
</%def>


<%def name="content()">
    <% counter = 0 %>
    <h3>${_(u'Comentarios')}</h>

    %if not c.user:
        ${_(u'login_first_to_comment')} <!-- Para hacer un comentario hace falta hacer login primero -->
    %else:
        <div class="centerize">
            <a href="/places/${c.place.id}/comments/new" class="accion bordeSoft" id="new-instant-btnSend">${_(u'Añadir comentario')}</a>
        </div>
    %endif

    ${functions.list_comments(c.ListComments)}
    ${c.ListComments.pager('Page $page: $link_previous $link_next ~4~')}
</%def>
