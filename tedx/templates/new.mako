<%inherit file="common.mako"/>

<%def name="title()">
    Pagina home
</%def>

<%def name="MainContent()">
    <div id="queMapa">

    <div align="right"><a href="/" class="close-icon"></a></div>

    <h2 class="mom">${_(u'Nueva Muestra')}</h2>	    
    <form id="new-instant-form" action="/content/fast_new_instant" enctype="multipart/form-data">
        <label for="new-instant-txtName">${_(u'Lugar de la muestra')}:<br /> 
            <input type="text" id="new-instant-txtName" name="new-instant-txtName"></input></label><br />

        <label for="new-instant-txtValuePH">${_(u'pH')}:<br />
            <input type="text" id="new-instant-txtValuePH" class="mask-num" name="new-instant-txtValuePH"></input></label><br />

        <label for="new-instant-txtValueCloro">${_(u'Cloro')}:<br />
            <input type="text" id="new-instant-txtValueCloro" class="mask-num" name="new-instant-txtValueChlorine"></input></label><br />

        <label for="new-instant-txtDescription">${_(u'description')}:</br>
            <textarea id="new-instant-txtDescription" name="new-instant-txtDescription"></textarea></label>
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
    <div class="centerize">
        <a href="javascript: new_happy_instant();" class="accion bordeSoft" id="new-instant-btnSend">${_(u'Enviar datos')}</a>
    </div>
</div>
</%def>

<%def name="head()">
    <link rel="stylesheet" type="text/css" href="/css/tablesorterstyle.css" />
    <link rel="stylesheet" type="text/css" href="/css/home.css" />
    <script type="text/javascript" src="/js/home.js"></script>
    <script type="text/javascript" src="/js/jquery.tagcloud.min.js" charset="utf-8"></script>
    <link rel="stylesheet" type="text/css" href="/css/screen.css" />
    <script type="text/ javascript">
         var user = "${c.user}";
    </script>
</%def>

<%def name="init()"></%def>

<%def name="content()">
    <h3>${_(u'Muestra de Agua Analizadas')}</h3>
    <div id="list"></div>
    <div id="srToolsDown"></div>
</%def>
