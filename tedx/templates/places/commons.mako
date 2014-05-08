<%namespace name="functions"  file="/functions.mako"/>
<%def name="edit_place(place)">
    edit place
</%def>

<%def name="show_place(place)">

    %if place:
        <div align="right"><a href="/" class="close-icon"></a></div>

            <div class="imagen">
                <img src="/images/${functions.GetDrop(c.place.ph, place.chlorine)}.png"/></a>
            </div>

            <h2>${place.name}</h2>

            <h3>${_(u'Descripción')}</h3>

            <div class="dataVision">
                <label>${_(u'Autor')}:</>
                <a href="/account/${place.user.nickname}">${place.user.nickname}</a>
            </div>

            <div class="dataVision">
                <label>${_(u'Creado')}:</>
                ${place.created_on}
            </div>

            <div class="dataVision">
                <label>${_(u'Descripción')}:</>
                ${place.comments[0].content}
            </div>

            <h3>${_(u'Medidas de la muestra')}</h3>
            <div class="dataVision">
                <label>${_(u'pH')}:</>
                    ${place.ph}
            </div>

            <div class="dataVision">
                <label>${_(u'Cloro')}:</>
                ${place.chlorine}
            </div>

            <h3>${_(u'Actividad')}</h3>
            <div class="dataVision">
                <label>${_(u'Comentarios')}:</>
                    <% comments = len(place.comments)-1 %>
                %if comments >0:
                    ${comments}
                %endif
            </div>

            <div class="dataVision">
                <label>${_(u'Visitas')}:</>
                ${place.visits}
            </div>

            <div class="dataVision">
                <label>${_(u'Puntuación')}:</>
                Falta!!!
            </div>

            % if len(place.comments[0].files)>0:
                <h3>${_(u'Imágenes')}</h3>
                <br>
                %for item in place.comments[0].files:
                    % if item.type == 'image':
                        <img class="imagen" src="${item.path}.jpg" /></a>
                    %endif
                %endfor
            %endif

            <br><br>
            %if c.user:
                %if place.user.nickname == c.user.nickname:
                    <div class="centerize">
                        <a href="/places/${place.id}/edit" class='accion  bordeSoft'  style='text-transform: uppercase:' id='grande'>
                            ${_(u'Editar')}
                        </a>
                        <a href="/places/${place.id}/delete" class='accion  bordeSoft' style='text-transform: uppercase:' id='grande'>
                            ${_(u'Borrar')}
                        </a>
                    </div>
                %endif
            %endif

        ##for comment_file in db_result.comments[0].files:
        ## if comment_file.type == "image":
        ## comment_image = comment_file.path


        ##<img class="imagen" src="' + data.comment_image  + '_small.jpg" /></a>

            <div class="clear"></div>
            <br/><br/>
        %endif
</%def>
