<%def name="GetDrop(ph,chlorine)">
<%
    ph = float(ph or 0)
    chlorine = float(chlorine or 0)

    if (ph>=6.5 and ph<=9.5):
        if (chlorine>=0 and chlorine<=0.5):
            return 'drop_blue'
        else:
            return 'drop_green'
    else:
        return 'drop_brown'

%>
</%def>

<%def name="list_comments(items)">
%if items:
    % for item in items:
        <div id="muestra-item">
            <div id="description">
                <h4><a href="/places/${item.place_id}">${_(u'Muestra')}</a></h4>
                    
                <br><a href="/places/${item.place_id}/comments/${item.id}">${_(u'Título')}:${item.title}</a>
                <br> ${_(u'Usuario')}:          ${item.user.nickname}
                <br> ${_(u'Muestra')}:          ${item.place.name}
                <br> ${_(u'Contenido')}:        ${item.content}
                <br> ${_(u'Fecha Creación')}:   ${item.created_on}
            </div>
        </div>
    % endfor
%endif
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
            <p>${_(u'Descripción')}: ${place.description}</p>
            <p>${_(u'Ultima actualización')}:${place.last_update}</p>   
               ${_(u'Comentarios')}:   ${ len(place.comments)}
               ${_(u'Visitas')}: ${place.visits}                      
               ##${_(u'Me gusta')}:
            </p>                                                                                                                                                             
        </div>                                                                                                                                                               
        <div class="clear"></div>  
        </div>
    % endfor
% endif
</%def>
