<%inherit file="/common.mako"/>
<%namespace name="functions"  file="/functions.mako"/>
<%namespace name="commons"  file="commons.mako"/>

<%def name="title()">${_(u'Editar Muestra')}</%def>

<%def name="head()">
    <link rel="stylesheet" type="text/css" href="/css/common.css" />

    <script type="text/javascript" src="/js/flowplayer-3.2.4.min.js"></script>
    <script type="text/javascript" src="/js/jquery.tagcloud.min.js" charset="utf-8"></script>
    <script type="text/javascript" src="/js/view.js" charset="utf-8"></script>

    <script type="text/javascript">
    </script>
</%def>

<%def name="title()">${_(u'Editar Muestra')}</%def>

<%def name="MainContent()">
    <div id="queMapa">
        <div align="right"><a href="/" class="close-icon"></a></div>

        <h2 class="mom">${_(u'Editar Comentario')}</h2>	    
        Commentario id:${c.comment.id}
        ${h.form(h.url_for(id=c.comment.id, place_id=c.comment.place_id), class_='accion bordeSoft') }
        <%include file="form.mako" />


        ${ h.end_form() }
</div>
</%def>

<%def name="init()"></%def>

<%def name="content()">
    <h3>${_(u'Muestra de Agua Analizadas')}</h3>
    <div id="list"></div>
    <div id="srToolsDown"></div>
</%def>
