<%inherit file="/common.mako"/>

<%def name="title()">${_(u'Nueva Muestra')}</%def>

<%def name="MainContent()">
    <div id="queMapa">

        <div align="right"><a href="/" class="close-icon"></a></div>

        <h2 class="mom">${_(u'Nueva Muestra')}</h2>	    
        ##${h.form(h.url_for(action='new')) }
        ${ h.form(url=h.url_for(), multipart=True) }
            <%include file="form.mako" />
            ${ h.submit('submit', _(u'Enviar'), class_='accion bordeSoft') }
        ${ h.end_form() }

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
        var latitude = "${c.latitude}";
        var longiude = "${c.longitude}";
    </script>
</%def>

<%def name="init()"></%def>

<%def name="content()">
    <div class="sidebarIzq">
        <%include file="../information/teachers.mako"/>
    </div>
                                                                  
    <div class="content_center">
        <h3>${_(u'Muestra de Agua Analizadas')}</h3>
        <div id="list"></div>
            <div id="srToolsDown"></div>
        </div>
                                                                    
        <div class="sidebarDer">
            <%include file="../information/datos.mako"/>
        </div>
</%def>
