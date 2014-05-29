<%inherit file="../base.mako"/>
<%namespace name="functions"  file="/functions.mako"/>
<%namespace name="commons"  file="commons.mako"/>

<%def name="title()"> ${_(u'Home')}</%def>

<%def name="MainContent()">
    <div id="queMapa">
        <div align="right"><a href="/" class="close-icon"></a></div>
        <h2>${_(u'Últimas Muestras')}</h2>
        ${commons.show_places( c.top_places )}
    </div>
</%def>

<%def name="content()">
    <h3>${_(u'Muestras enviadas')}</h3>
    ${c.AllPlaces}
    ${functions.list_places(c.ListPlaces)}
    </br>
    ${c.ListPlaces.pager(
        link_attr = {'class':'accion bordeSoft'},
        curpage_attr = {'class': 'seleccion bordeSoft'},
        dotdot_attr = {'class': 'accion bordeSoft'})}
</%def>
