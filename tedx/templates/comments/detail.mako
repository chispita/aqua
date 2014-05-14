# -*- coding: utf-8 -*-
<%inherit file="../common.mako"/>
<%namespace name="functions"  file="/functions.mako"/>
<%namespace name="commons"  file="commons.mako"/>
<%def name="title()">${_(u'View Comment')}</%def>

<%def name="head()">
    <link rel="stylesheet" type="text/css" href="/css/common.css" />

    <script type="text/javascript" src="/js/flowplayer-3.2.4.min.js"></script>
    <script type="text/javascript" src="/js/jquery.tagcloud.min.js" charset="utf-8"></script>
    <script type="text/javascript">
    </script>
</%def>

<%def name="extra_body()">
    <body onload="map_load()">
</%def>

<%def name="init()">
</%def>
<%def name="MainContent()">
    <div id="queMapa">
        ${commons.show_comment(c.comment)}
    </div>
</%def>


<%def name="content()">
        <h3>${_(u'Comentarios')}</h>

        %if not c.user:
            ${_(u'login_first_to_comment')} <!-- Para hacer un comentario hace falta hacer login primero -->
        %else:

        %endif
</%def>
