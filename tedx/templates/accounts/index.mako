# -*- coding: utf-8 -*-
<%inherit file="../common.mako"/>
<%namespace name="functions"  file="/functions.mako"/>

<%def name="title()">
    ${_(u'Usuarios Registrados')}
</%def>

<%def name="head()">
    <script type="text/javascript" src="/js/my_account.js">
    </script>

    <link rel="stylesheet" type="text/css" href="/css/my_account.css" />
    </script>

    <script type="text/javascript">
        function map_load() {
            // Acercamos el zoom lo mas cerca posible
            % for place in c.AllPlaces :

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

<%def name="MainContent()">
    <div  id="queMapa">
        <div align="right"><a href="/" class="close-icon"></a></div>
        <h2>${_(u'Usuarios Registrados')}</h2>
    </div>
</%def>  
                
<%def name="content()">
    <h3>${_(u'Usuarios Registrados')}</h3>
    ${functions.list_users(c.Users)}
    ${c.Users.pager('Page $page: $link_previous $link_next ~4~')}
</%def>

