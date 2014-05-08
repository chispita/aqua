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

        % if c.place_id:
            place_id = "${c.place_id}";
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
  <div id="loading_div" style="padding-top:20px; display: none">
    ${_(u'sending_processing_please_wait')}
    </div>

  <div id="new_comment_div" style="padding-top: 10px;">
    <div class="sidebarIzq">
        <%include file="../information/teachers.mako"/>
    </div>
    <% counter = 0 %>

    <div class="content_center">
        <h3>${_(u'Comentarios')}</h>
        % for comment in c.place.comments:
            <% counter += 1 %> 
            % if counter >1:
            <div id="muestra-item">
                <div id="description">
                    <h4>${comment.title}</h4>
                    <p>${comment.user.nickname}</p>
                    <p>${comment.last_update}</p>
                    <p>${comment.content}</p>
                    <p>${comment.positive_scorings}</p>
                </div>
            </div>
            % endif
        % endfor

        <div id="add_comment">
            <h3><br>${_(u'Añadir comentario')}</h3>
            %if not c.user:
                ${_(u'login_first_to_comment')} <!-- Para hacer un comentario hace falta hacer login primero --i
                <!--  Faltaria un enlace al login -->
            %else:
                <div id="manchaIzda">

                <div class="colDetStreetr">
	                <div id="descripcionStreetr">
                        <a class="titulo01">${_(u'Comentario')}</a>
                        <textarea id="comment_content" class="long_textarea"></textarea>
                    </div>

	                <div id="selecImages">
                        <a class="titulo01">${_(u'Adjunto')}</a>
	                    <div style="clear:both; height:20px; padding-top:10px;">
		                    <div id="botonSubirImg">
		                        <a class="estiloAzul" href="javascript:new_attachment('image');">
		                            <img src="/images/iconoFotografia.png" alt="Subir Imagen" longdesc="Click aqui para subir una nueva imagen. Tamaño Máximo 10x15.Resolución 72 dpi." />
                                        ${_(u'image')}
		                            </a>
		                        </div>
	                        </div>

                            <div id="link" title="link">

		                    <form>
		                        <fieldset>
		                            <input type="text" id="youtube_link" name="file">
		                            </input>
		                        </fieldset>
		                    </form>
	                    </div>
	      
	                    <div id="files"></div>
	                    <iframe style="display:none;" id="file_upload_iframe" name="file_upload_iframe"></iframe>
	                </div>

	            </div>
	  
                <a href="javascript:void(0);" onclick="new_comment();" class="accion bordeSoft">${_(u'save')}</a>
	  </div>
	</div>
	% endif
</div>
    </div>

    <div class="sidebarDer">
        <i%include file="../information/datos.mako"/>
    </div>
    
    <div id="attachment_modal" title="Attachment" style="z-index: 9999;"></div>
</%def>
