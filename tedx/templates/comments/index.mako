# -*- coding: utf-8 -*-
<%inherit file="../common.mako"/>
<%namespace name="functions"  file="/functions.mako"/>

<%def name="title()">
    ${_(u'Comentarios')}
</%def>

<%def name="head()">
    <script type="text/javascript" src="/js/my_account.js">
    </script>

    <link rel="stylesheet" type="text/css" href="/css/my_account.css" />
    </script>

    <script type="text/javascript">

        ##% if c.user.latitude and c.user.longitude:
        ##    latitude = "${c.user.latitude}"
        ##    longitude = "${c.user.longitude}"
        ##% endif
        ##% if c.user:
        ##    user_id = "${c.user.id}";
        ##% endif
    </script>
</%def>

<%def name="init()"></%def>

<%def name="MainContent()">
    <div  id="queMapa">
        <div align="right"><a href="/" class="close-icon"></a></div>
        <h2>${_(u'Comentarios')}</h2>
    </div>
</%def>  
                
<%def name="content()">
    <h3>${_(u'Comentarios Registrados')}</h3>
    ${functions.list_comments(c.Comments)}
    ${c.Comments.pager('Page $page: $link_previous $link_next ~4~')}
</%def>

