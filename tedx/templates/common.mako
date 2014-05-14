# -*- coding: utf-8 -*-
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"> 
<%def name="extra_body()"/>
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <title>AQUA - ${next.title()}</title>
        <%include file="meta.mako"/>

        ##<%namespace name="functions"  file="functions.mako"/>

	    <link rel="shortcut icon" href="/images/favicon.ico" />
        <link rel="stylesheet" type="text/css" href="/css/common.css" />
        <link rel="stylesheet" type="text/css" href="/css/jquery-ui-1.8.9.custom.css" />
        <link rel="stylesheet" type="text/css" href="/css/jquery.fileupload-ui.css" />
        
	    <script type="text/javascript" src="/js/jquery-1.6.2.min.js"></script>
        <script type="text/javascript" src="/js/jquery.json-2.2.min.js"></script>
        <script type="text/javascript" src="/js/geo.js" charset="utf-8"></script>
        <script src="https://maps.googleapis.com/maps/api/js?v=3.exp&sensor=false"></script>
        <script type="text/javascript" src="/js/common.js"></script>
        <script type="text/javascript" src="/common/translation"></script>
        <script type="text/javascript" src="/js/jquery-ui-1.8.9.custom.min.js"></script>

        <script type="text/javascript" src="js/jquery.keyfilter-1.7.js"></script>
	    <script type="text/javascript" src="/js/jquery.form.js"></script>

        ${next.head()}


        <script type="text/javascript">

            function create_map() {
                var myOptions = {
                    zoom: 13,
                    mapTypeControl: true,
                    mapTypeControlOptions: {
                        style: google.maps.MapTypeControlStyle.DROPDOWN_MENU,
                        position: google.maps.ControlPosition.BOTTOM_LEFT
                        },
                    navigationControl: true,
                    mapTypeId: google.maps.MapTypeId.ROADMAP,
                    center: new google.maps.LatLng(41.65, -0.88)
                    };

                var map = new google.maps.Map($('#map')[0], myOptions);
                    google.maps.event.addListenerOnce(map, 'idle', function() {
                    for(var it in google.maps.MapTypeId) {
                        map.mapTypes[google.maps.MapTypeId[it]].minZoom = 3;
                        map.mapTypes[google.maps.MapTypeId[it]].maxZoom = 17;
                        }
                    });
                return map;
            };

	     $(document).ready( function() {
            %if not "app_message" in session:
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
            ${next.init()}

        });

        </script>
    </head>

    <body>

        <a href="#muestras">
        <%include file="messages.mako"/>
        <%include file="cabecera.mako"/>

        <div id="map_container">
            <input type="hidden" id="city" value="${c.city}"/>
            <input type="hidden" id="country" value="${c.country}"/>
                        
                <div class="map_legend">
                <div id="MainContent">
                    ${next.MainContent()}
                </div>
             </div>
            <div id="map"></div>      
        </div>

        <%include file="search_map.mako"/>

         ${self.extra_body()}

        <div style="clear: both;"></div>

        <div class="sidebarIzq">
            <%include file="information/teachers.mako"/>
        </div>

        <div class="content_center">
            <div id="content">${next.content()}</div>        
        </div>
                                                                    
        <div class="sidebarDer">
            <%include file="common/information.mako"/>
        </div>

        ##<div id="contentIzd">${next.contentIzd()}</div>        

        <div class="clear"></div>

        <%include file="common/footer.mako"/>
        <div class="clear"></div>
        <%include file="common/logos.mako"/>


    </div>
     <iframe style="display:none;" id="file_download_iframe" name="file_download_iframe"></iframe>
    </body>
</html>
