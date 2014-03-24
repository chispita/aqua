# -*- coding: utf-8 -*-
## home.mako ##
<%inherit file="common.mako"/>

<%def name="title()">
  ${_(u'home')}
</%def>

<%def name="head()">
  <link rel="stylesheet" type="text/css" href="/css/tablesorterstyle.css" />
  <link rel="stylesheet" type="text/css" href="/css/home.css" />
  <script type="text/javascript" src="/js/home.js"></script>
  <script type="text/javascript" src="/js/jquery.tagcloud.min.js" charset="utf-8"></script>
  <link rel="stylesheet" type="text/css" href="/css/screen.css" />	
  <script type="text/javascript">
    var user = "${c.user}";
  </script>
</%def>

<%def name="init()"></%def>

<%def name="content()">
    <div class="sidebarIzq">
        <h3>${_(u'Información para Profesores')}</h3>
        ${_(u'Queremos repartir kits experimentales a todos los centros de Educación Secundaria que lo deseen, pero nuestro presupuesto es limitado. Mandanos un correo a')} <a href="mailto:info@ibercivis.es">info@ibercivis.es</a> ${_(u'indicando en el asunto AQUA y con los detalles de centro y de la persona de contacto')}.
        <br /><br />
        ${_(u'Fecha límite para recepción de solicitudes de los centros: 22 de Abril de 2014')}.
        <br /><br />
        ${_(u'Nota: en caso de recibir más solicitudes de las que somos capaces de financiar, se dará prioridad a los centros de Zaragoza')}.
    </div>
  
    <div class="content_center">
        <h3>${_(u'Muestra de Agua Analizadas')}</h3>
        <div id="list"></div>
        <div id="srToolsDown"></div>
    </div>
  
    <div class="sidebarDer">
        <%include file="datos.mako"/>
    </div>
</%def>
