# -*- coding: utf-8 -*-
<%inherit file="../common.mako"/>
<%namespace name="functions"  file="/functions.mako"/>


<%def name="title()">
    ${_(u'Configuración')}
</%def>

<%def name="head()">
    <script type="text/javascript" src="/js/my_account.js">
    </script>

    <link rel="stylesheet" type="text/css" href="/css/my_account.css" />
    </script>

    <script type="text/javascript">
        function map_load() {
            // Acercamos el zoom lo mas cerca posible
            % for place in c.places_map :
                html =  '<table>' +
                        '<tr><td colspan="2">' +
                        '<a class="estiloAzul" href="/places/${place.id}"</a>'+
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
    <div id="queMapa">
        <div align="right"><a href="/" class="close-icon"></a></div>
        <h2>${_(u'Configuración')}: ${c.user.nickname}</h2>

        <label for="new-session-txtName">${_(u'Nombre')}<br />
        <input type="text" id="nickname" maxlength="32" value="${c.user.nickname}"> </input>
        </label><br/>

        <label for="new-session-txtName">${_(u'Email')}<br />
        <input type="text"  id="email" maxlength="32" value="${c.user.email}"> </input>
        </label><br/>

        <label for="new-session-txtName">${_(u'Contraseña Anterior')}<br />
        <input type="password"  id="password1" maxlength="32"> </input>
        </label><br/>

        <label for="new-session-txtName">${_(u'Contraseña Nueva')}<br />
        <input type="password"  id="password2" maxlength="32"> </input>
        </label><br/>

        <br><br>
        <div class="centerize">
            <a class="left accion bordeSoft"  href="javascript:void(0)" onclick="save()" id="print_Stickers_button">${_(u'Guardar')}</a>
            <br><br>
        </div>
    </div>
</%def>  
                
<%def name="content()">
    <h3>${_(u'Muestra de Agua Analizadas')}</h3>
    <div id="list"></div>
    <div id="srToolsDown"></div>
</%def>

