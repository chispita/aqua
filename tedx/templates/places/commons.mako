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
                <label>${_(u'Autor')}:
                <strong><a href="/account/${place.user.nickname}">${place.user.nickname}</a></strong>
                </label>
            </div>

            <div class="dataVision">
                <label>${_(u'Creado')}:
                    <strong>${place.created_on}</strong>
                </label>
                <label>${_(u'Tomada')}:
                    <strong>${place.take_on}</strong>
                </label>

            </div>

            <div class="dataVision">
                <label>${_(u'Descripción')}: 
                    <strong>${place.description}</strong>
                </label>
            </div>

            <h3>${_(u'Dirección')}</h3>
            <div class="dataVision">
                <label>${place.address}</label><br>
                <label>${place.postalcode} ${place.city}</label>
            </div>


            <h3>${_(u'Medidas de la muestra')}</h3>
            <div class="dataVision">
                <label>${_(u'pH')}:     <strong>${place.ph}</strong></label>
                <label>${_(u'Cloro')}:  <strong>${place.chlorine}</strong></label>
            </div>

            <h3>${_(u'Actividad')}</h3>
            <div class="dataVision">
                <label>${_(u'Comentarios')}:<strong> ${len(place.comments)}</strong>
                |${_(u'Visitas')}:
                <strong>${place.visits}</strong>
                </label>
            </div>
    
            %if len(place.comments)>0:
                <h3>${_(u'Imágenes')}</h3>
                %for item in place.comments[0].files:
                    % if item.type == 'image':
                        <img class="imagen" src="${item.path}.jpg" /></a>
                    %endif
                %endfor
            %endif

            </br>
            %if c.user:
                %if place.user.id == c.user.id:
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

            <br/><br/>
        %endif
</%def>
