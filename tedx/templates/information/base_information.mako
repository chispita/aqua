# -*- coding: utf-8 -*-
<%inherit file="../common.mako"/>
<%namespace name="functions"  file="/functions.mako"/>
<%def name="title()">
    ${next.title()}
</%def>

<%def name="head()">
    <link rel="stylesheet" type="text/css" href="/css/my_account.css" />

</%def>
<%def name="init()"></%def>


<%def name="MainContent()">
    <div id="MsgOverMap">

        <div align="right"><a href="/" class="close-icon"></a></div>
        ${next.contain()}
    </div>

</%def>  
                
<%def name="content()">
    <h3>${_(u'Mestras enviadas')}</h3>
    ${c.AllPlaces}
    ${functions.list_places(c.ListPlaces)}    

    #${c.ListPlaces.pager('Page $page: $link_previous $link_next ~4~')}

</%def>

