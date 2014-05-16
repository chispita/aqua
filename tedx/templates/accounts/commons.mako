<%def name="edit_user(user)">
    edit user
</%def>

<%def name="show_user(user)">
    %if user:
        ## Si no exite el usuario logeado-> perfil publico

        ##% if not c.user:
        ##    Sin usuario registrado <br>
        ##    <% link = '/account/' + user.nickname %>
        ##%else:
        ##    ## Si el logeado coincide con el que se quiere ver -> perfil privado
        ##    mostrado: ${user.nickname}<br>
        ##    registrado: ${c.user.nickname}<br>
        ##    %if user.nickname == c.user.nickname:
        ##        registrado
        ##        <% link = '/account' %>
        ##    %else:
        ##        buscado
        ##        <% link = '/account/' + user.nickname %>
        ##    %endif
        ##%endif

        <div align="right"><a href="/" class="close-icon"></a></div>
            <h2>${user.nickname}</h2>
            <h3>${_(u'Datos')}</h3>
            <div class="dataVision">
                <label>${_(u'Descripción')}
                    <strong>${user.description}</strong>
                </label>
            </div>

            <div class="dataVision">
                <label>${_(u'Fecha Creación')}:                    
                    <strong>${user.created_on}</strong>
                </label>
            </div>

            <div class="dataVision">
                <label>${_(u'Última Actividad')}:
                    <strong>${user.last_activity}</strong>
                </label>
            </div>

            <h3>${_(u'Actividad')}</h3>
            <div class="dataVision">
                <a href="#muestras">
                    <label>${_(u'Muestras')}:
                        <strong>${len(user.places)}</strong>
                    </label>
                    </a>    

                $ h.link_to( 
                    _(u'Comentarios') + ':' + str(len(user.comments)),
                    h.url_for(controller='account', 
                    action='comments', 
                    nickname=user.nickname)) }
            </div>

            <div class="dataVision">
                <% visits = 0 %>
                %for place in user.places:
                    <% visits = visits + place.visits %>
                %endfor

                ${ h.link_to( 
                    _(u'Visitas') + ':' + str(visits),
                    h.url_for(controller='account', 
                    action='visits', 
                    nickname=user.nickname)) }
            </div>
            <br><br>

            ##%if c.user:
            ##    %if user.nickname == c.user.nickname:

            ##        <div class="centerize">
            ####            <a href='/account/settings/' class='accion right bordeSoft' style='text-transform: uppercase:' id='grande'>
            ##            ${_(u'Editar')}</a>
            ##        </div>
            ##    %endif
            ##%endif

        %endif
</%def>
