# -*- coding: utf-8 -*-
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"> 
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <title>AQUA - ${next.title()}</title>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
	<meta name="Keywords" content="quality, water, geotagging, geolocalización, social network, red social, mapa"/>
    <meta name="Description" content="Aqua ibercivis lets you tag water quality places and sharing them with your friends.\
										  by selecting a place in a map  \
                                          . With this app you can share water qualitys, images and videos as well as comment \
										  on other people posts."/> 
                                          <meta name="Author" content="Ibercivis"/>
	<meta name="Identifier" scheme="URI" content="http://aqua.ibercivis.es"/>
    <meta name="page-topic" content="water,quality,geotagging, geolocalización, social network, red social,mapa"/>
	<meta name="audience" content="All"/>
	<meta name="Rating" content="General"/>
	<meta name="Distribution" content="Global"/>
        
	<link rel="shortcut icon" href="/images/favicon.ico" />
        <link rel="stylesheet" type="text/css" href="/css/common.css" />
        <link rel="stylesheet" type="text/css" href="/css/jquery-ui-1.8.9.custom.css" />
        <link rel="stylesheet" type="text/css" href="/css/jquery.fileupload-ui.css" />
        
	<script type="text/javascript" src="/js/jquery-1.6.2.min.js"></script>
        <script type="text/javascript" src="/js/jquery.json-2.2.min.js"></script>
        <script type="text/javascript" src="/js/geo.js" charset="utf-8"></script>
        <script type="text/javascript" src="http://maps.google.com/maps/api/js?sensor=false"></script>
        <script type="text/javascript" src="/js/common.js"></script>
        <script type="text/javascript" src="/common/translation"></script>
        <script type="text/javascript" src="/js/jquery-ui-1.8.9.custom.min.js"></script>
	<script type="text/javascript" src="/js/jquery.form.js"></script>

        ${next.head()}

        <script type="text/javascript">
	  $(document).ready( function() {
	  % if not "app_message" in session:
          <%
            session['app_message'] = True
            session.save()
            %>
          var uagent = navigator.userAgent.toLowerCase();
	  
          if ((navigator.platform.search("iPhone") > -1) || (navigator.platform.search("iPod") > -1)) {
          var answer = confirm("${_(u'iphone_application_exists')}")
          if (answer) {
          window.location = "http://itunes.apple.com/app/feelicity/id452958224?mt=8";
          }
          }
	  
          if (uagent.search("android") > -1) {
          var answer = confirm("${_(u'android_application_exists')}")
          if (answer) {
          window.location = "https://market.android.com/details?id=com.bifi.feelicity";
          }
          }
          % endif
	  
          % if c.message:
          tedx_alert("${c.message}");
          % endif
          common_init();
	  ${
          next.init()}
          % if c.user:
          get_profile_data();
          %endif
          });
        </script>
    </head>
    <body>
      <div id="notification">
	<p>
	  ${_(u'Has creado tu contenido con éxito.')} ${_(u'¿Quieres compartirlo?')}
	  <a id="facebook-share-link" href="#" target="_blank">Facebook</a>&nbsp;|&nbsp;<a id="twitter-share-link" href="#" target="_blank">Twitter</a>
	</p>
	<a href="#" class="close">X</a>
      </div>

    <div id="contenedor">
     <div id="cabecera">
         <div id="idioma" style="margin-top: 10px;">
            %if not c.user:
                 ${_(u'Login')}
             %else:
                 ${_(u'hello')} <a href="/my_account"><span class="username">${c.user.nickname}</span></a>
                <a href="javascript:logout();">${_(u'Salir')}</a>
            %endif
	    <a href="javascript: change_language('es')">Español</a> / <a href="javascript: change_language('en')">English</a>
	  </div>
	  <div id="logotipo" style="float:left; margin">
	    <a href="/"><img src="/images/logo-web-fondo-transparente.png" alt="Logo Tedx"  /></a>
	  </div>
	  %if not c.user:
	  <div id="login" class="right">
	    <form id="form1" method="post" action="/common/form_login" >
	      <div id="logLeft" class="bordeHalf">
			<div for="usuario" >${_(u'usuario / email')}</div><input type="text"  name="login_email" id="login_email"></input>
			<div for="password" >${_(u'password')}</div><input type="password" name="login_password" id="login_password" onkeydown="if ((event.which && event.which == 13) || (event.keyCode && event.keyCode == 13)) {$('#form1').submit();}"></input>
			<a href="javascript: forgot_password();" id="lost" class="left">${_('forgotten_password')}</a>
			<a href="#" onclick="$('#form1').submit();" style="text-transform: uppercase;" class="accion right bordeSoft">${_(u'log_in')}</a>
	      </div>
	      <div id="logRight">
		<p>${_(u'login_question')}</p>
		<a href="javascript:register_user();" class="registro left bordeSoft" style="text-transform: uppercase;">${_(u'register')}</a>
	      </div>
	    </form>
	  </div>
  % else:
      <!--
	  <div id="login" class="right">
	  	<div id="logLeft" class="bordeHalf">
		  	<h2>${_(u'hello')} <a href="/my_account"><span class="username">${c.user.nickname}</span></a>!</h2>
            <span class="logOut"><a href="javascript:logout();">Salir</a></span>
		  	<div id="placesUp" class="stat"></div>
		  	<div id="commentsUp" class="stat"></div>
		  	<!--div id="visitsUp" class="stat"></div-->
		  	<div id="likeUp" class="stat"></div>	
	  	</div>
	  	
	  	<img src="${c.user.avatar}_mid.png" width=136 height=136 alt=${c.user.nickname} />
	  	
        </div>
      -->
	  %endif

	  <div id="MenuTop">
	  </div>
	</div>
            
	<div id="map_container">
	  <input type="hidden" id="city" value="${c.city}"/>
	  <input type="hidden" id="country" value="${c.country}"/>
	  	
	  <div class="map_legend">
	    <div id="queMapa">
	      
	    %if not c.user:
	        ${_(u'what_map')|n}
        %else:
           <!-- Formulario Flotante  -->
	      <h2 class="mom">${_(u'new_place')}</h2>	    
        <form id="new-instant-form" action="/content/fast_new_instant" enctype="multipart/form-data">
		<label for="new-instant-txtName">${_(u'title')}: <input type="text" id="new-instant-txtName" name="new-instant-txtName" placeholder="${_(u'Nombre')}"></input></label>
		<br /><br />
		<label for="new-instant-txtDescription">${_(u'description')}:<textarea id="new-instant-txtDescription" name="new-instant-txtDescription" placeholder="${_(u'Descripción')}"></textarea></label>
		<div class="clear"></div>
		<br />
		<div>
		  <img src="/images/iconoFotografia.png" alt="Añadir imagen" /> <label>${_(u'image')}:</label>
		  <input size="12" type="file" id="new-instant-image" name="new-instant-image" /> 
		</div>
		<br />
		<input type="hidden" id="new-instant-txtLatitude" name="new-instant-txtLatitude" />
		<input type="hidden" id="new-instant-txtLongitude" name="new-instant-txtLongitude" />
		<input type="hidden" id="new-instant-city" name="new-instant-city"/>
		<input type="hidden" id="new-instant-country" name="new-instant-country"/>
	      </form>
	      <br /><br />
	      <a class="avanzado" href="/content">${_(u'advanced')}</a>&nbsp;&nbsp;&nbsp;<a href="javascript: new_happy_instant();" class="registro bordeSoft" id="new-instant-btnSend">${_(u'Enviar datos')}</a>
	      %endif
	    </div>
	  </div>
	  <div id="map"></div>      
	</div>

	<div id="buscarMapa" class="left  clear">
	  <label for="srch" style="float:left;padding:5px 0px;"><input type="text" id="search_string" placeholder="Buscar muestras" onkeydown="if ((event.which && event.which == 13) || (event.keyCode && event.keyCode == 13)) {search_query();}"></input></label>
	  <a href="javascript:void(0);" onclick="search_query();" class="left accion bordeSoft">${_(u'search')}</a>
	  <a href="javascript:void(0);" onclick="get_current_position(on_position_success, on_position_error);" class="left accion bordeSoft" id="geo">${_(u'geolocation')}</a>
	  
	</div>

	<div style="clear: both;"></div>
            
	<!-- End Save for Web Slices -->
	<div id="content">
	  ${next.content()}
	</div>
	<div class="clear">
	</div>
	
	<div id="barraFooter">
	  <div class="footer-element">
	    <a href="javascript: open_team_dialog();">${_(u'equipo')}</a>&nbsp;|&nbsp;
	    <a href="javascript: open_about_dialog();">${_(u'acerca de')}</a>&nbsp;|&nbsp;
	    <a href="javascript: open_disclaimer_dialog();">${_(u'disclaimer')}</a>&nbsp;|&nbsp;
	    <a href="javascript: send_contact_message();">${_(u'contacto')}</a>
	  </div>
	</div>
	<div class="clear">
	</div>
      </div>
      <iframe style="display:none;" id="file_download_iframe" name="file_download_iframe"></iframe>



      <!-- Dialog windows -->
      <div id="dialog-forgotten-password" title="${_(u'Recuperar contraseña')}">
	<p>
	  ${_(u'Introduce el email con el que te registraste y te enviaremos tu nueva contraseña allí.')}
	</p>
	<input type="text" id="dialog-forgotten-password-txtEmail" style="width: 200px;"/>
	<br />
	<br />
	<img id="dialog-forgotten-password-imgLoading" src="/images/loading.gif" alt="Loading image" style="height: 100px; width: 100px;" />
	<button id="dialog-forgotten-password-btnAccept">
	  ${_(u'accept')}
	</button>
	<button id="dialog-forgotten-password-btnCancel">
	  ${_(u'cancel')}
	</button>
      </div>
      <div id="dialog-registration" title="${_(u'Registro de usuario')}">
	<label for="dialog-registration-txtEmail" class="form-label">
	  ${_(u'email')}*:
	</label>
	<br />
	<input type="text" id="dialog-registration-txtEmail" maxlength="256" class="form-input" />
	<br />
	
	<label for="dialog-registration-txtContra" class="form-label">
	  ${_(u'password')}*:
	</label>
	<br />
	<input type="password" id="dialog-registration-txtContra" maxlength="32" class="form-input" />
	<br />
	
	<label for="dialog-registration-txtContraConfirmation" class="form-label">
	  ${_(u'repeat_password')}*:
	</label>
	<br />
	<input type="password" id="dialog-registration-txtContraConfirmation" maxlength="32" class="form-input" />
	<br />
	
	<label for="dialog-registration-txtNickname" class="form-label">
	  ${_(u'nickname')}*:
	</label>
	<br />
	<input type="text" id="dialog-registration-txtNickname" maxlength="32" class="form-input" />
	<br />
	
	<div id="sex_container" class="form-label">
	  ${_(u'sex')}*:
	</div>
	<label for="dialog-registration-rdMan" class="form-label">
	  ${_(u'man')}
	</label>
	<input id="dialog-registration-rdMan" name="dialog-registration-rdSex" type="radio" value="V" />
	<label for="dialog-registration-rdWoman" class="form-label">
	  ${_(u'woman')}
	</label>
	<input id="dialog-registration-rdWoman" name="dialog-registration-rdSex" type="radio" value="M" />
	
	<br />
	<br />
	<img id="dialog-registration-imgLoading" src="/images/loading.gif" alt="Loading image" style="height: 100px; width: 100px;" />
	<button id="dialog-registration-btnAccept">
	  ${_(u'accept')}
	</button>
	<button id="dialog-registration-btnCancel">
	  ${_(u'cancel')}
	</button>
      </div>
      <div id="dialog-contact" title="${_(u'Contacta con el equipo de AQUA')}">
	<label for="dialog-contact-txtName" class="form-label">
	  ${_(u'Nombre')}:
	</label>
	<br />
	<input type="text" id="dialog-contact-txtName" class="form-input" />
	<br />
	
	<label for="dialog-contact-txtEmail" class="form-label">
	  ${_(u'email')}*:
	</label>
	<br />
	<input type="text" id="dialog-contact-txtEmail" maxlength="256" class="form-input" />
	<br />
	
	<label for="dialog-contact-txtContent" class="form-label">
	  ${_(u'Contenido')}*:
	</label>
	<br />
	<textarea id="dialog-contact-txtContent" class="form-label">
	</textarea>
	<br />
	<br />
	<img id="dialog-contact-imgLoading" src="/images/loading.gif" alt="Loading image" style="height: 100px; width: 100px;" />
	<button id="dialog-contact-btnAccept">
	  ${_(u'accept')}
	</button>
	<button id="dialog-contact-btnCancel">
	  ${_(u'cancel')}
	</button>
      </div>
      <div id="dialog-team" title="${_(u'Equipo')}">
	<div>
	  <p>Para este proyecto, Ibercivis se beneficia de la experiencia de este grupo de profesionales:
        <b>Francisco Sanz</b>, tiene relación directa con la comunidad científica para brindarles la plataforma Ibercivis que permite contactar con la ciudadanía y la ciencia ciudadana. Desarrollador de herramientas para este nuevo tipo de ciencia. Divulgador en distintos foros acerca de computación y ciencia ciudadana.
        <br />
        <b>Carlos Val</b> es desarrollador de infraestructuras de ciencia ciudadana. Encargado de las relaciones con entidades externas para desarrollar proyectos de ciencia ciudadana.
        <br />
        <b>Eduardo Lostal Lanza</b> es desarrollador de aplicaciones web y móvil para proyectos de ciencia ciudadana. Presente en distintos congresos relacionados con el ámbito de la ciencia ciudadana. Director de proyectos fin de carrera relacionados con ciencia ciudadana.
        <br />
        <b>M.Carmen Ibáñez Hernández</b> es encargada de la sección de divulgación y difusión dentro de la fundación así como organizadora de eventos de ciencia ciudadana, cuenta con 5 años de experiencia desarrollando actividades con la ciudadanía.
      </p>

      <mako:include file="equipo.mako"/>
	  
	  <br />
	  <div style="clear:both;">
	    <button id="dialog-team-btnAccept">
	      Aceptar
	    </button>
	  </div>
  </div>
  <mako: include file="about.mako"/>

	<div id="dialog-more-info" title="Más información sobre el estudio">
	  <p style="font-size:14px; text-align: justify;">
	    El ayuntamiento de la la ciudad de Zaragoza realiza a través de su Instituto Municipal de Salud Pública un control de la calidad del agua periódico y los resultados analíticos pueden ser consultados <a href="http://www.zaragoza.es/ciudad/IMSP/sanidad/listado_IMSP" target="_blank">aquí</a>. Este control se realiza según los parámetros definidos en el Real Decreto 140/2003 y sus modificaciones.
        <br />
        Uno de los parámetros de control, cuyo nivel permite mantener “a raya” a los contaminantes microbiológicos es el cloro, incluso a concentraciones muy bajas tiene una importante actividad biocida. Conservar los límites de concentración del clore en nuestros grifos, fuentes, etc, estimados por legislación y suficientes para inhibir el crecimiento microbiano, es una tarea a veces no demasiado fácil.
        <br />
        Sería lógico suponer que un aumento en la concentración de cloro disponible en una solución traería un aumento correspondiente en la actividad biocida. Esta suposición puede ser verdad, mientras que otros factores, tales como el pH, la temperatura y el contenido de materia orgánica se mantengan constantes.
        <br />
        El poder biocida del cloro depende mucho de su no disociación en solución acuosa que está directamente relacionada al pH. Un aumento en el pH diminuye sustancialmente la actividad biocida del cloro, y una disminución del pH aumenta esa actividad en la misma proporción. Desde principios del siglo XX, se demostró esta dependencia del pH en la formación del ácido hipocloroso, forma más eficaz de la actividad biocida de los compuestos clorados, y por consiguiente, en la eficacia del cloro.
	  </p>
	  <br />
	</div>
	
    </body>
  </html>