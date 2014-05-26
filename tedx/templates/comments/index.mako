# -*- coding: utf-8 -*-
<%inherit file="../base.mako"/>
<%namespace name="functions"  file="/functions.mako"/>

<%def name="title()">
    ${_(u'Comentarios')}
</%def>

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

