<%def name="GetDrop(ph,chlorine)">
<%
    ph = float(ph or 0)
    chlorine = float(chlorine or 0)
    if ((chlorine < 0.5) or (chlorine > 2) or (ph < 6.5) or (ph > 9.5)):
        return 'drop_brown'
    elif (chlorine >= 0.5 and chlorine <= 0.9) or (chlorine >= 1.1 and chlorine <= 2) and ph>=6.5 and ph <=9.5:
        return 'drop_green'
    else:
        return 'drop_blue'
%>
</%def>

<%def name="list_users(users)">
%if users:
    % for user in users:
        <div id="muestra_item">

        <div class="description">
            <h4><a href="/account/${user.nickname}">${user.nickname}</a></h4>
            <br> ${_(u'Descrición')}:       ${user.description}
            <br> ${_(u'Fecha Creación')}:   ${user.created_on}
            <br> ${_(u'Última Actividad')}: ${user.last_activity}
            <br> ${_(u'Muestras')}:         ${len(user.places)}
            <br> ${_(u'Comentarios')}:      ${len(user.comments)}
            <br>
            <br>${_(u'Visitas')}:
            <% visits = 0 %>
            %for place in user.places:
                <% visits = visits + place.visits %>
            %endfor
            ${visits}
        </div>

        </div>
    % endfor

%endif
</%def>
<%def name="list_places(places)">
% if places:
    % for place in places:
        <div id="muestra_item">
            <div class="imagen">                                                                                                                                   
            <a href="/places/${place.id}"><img src="/images/${GetDrop(ph=place.ph, chlorine=place.chlorine)}.png"/></a>
            <br> ${_(u'pH')}:  ${place.ph}
            <br> ${_(u'Cl')}:  ${place.chlorine}  
        </div>                            
        <div class="description">
            <h4><a href="/places/${place.id}">${place.name}</a></h4>                                                                                                  
            <p>Description: ${place.comments[0].content}</p>                                                                                                                 
            <p>last Update:${place.last_update}</p>   
            <p>                                      
            <% comments = len(place.comments)-1 %>                
            ${_(u'Comentarios')}:   ${comments}
            ${_(u'Visitas')}: ${place.visits}                                                                                                                            
            ${_(u'Me gusta')}:                                                                                                                                           
            </p>                                                                                                                                                             
        </div>                                                                                                                                                               
        <div class="clear"></div>  
        </div>
    % endfor
% endif
</%def>
