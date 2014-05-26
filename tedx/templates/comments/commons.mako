<%namespace name="functions"  file="/functions.mako"/>

<%def name="show_comment(comment)">
    %if comment:
        <div align="right"><a href="/" class="close-icon"></a></div>

        <h2>${comment.title}</h2>

        <h3>${_(u'Descripción')}</h3>

        <div class="dataVision">
            <label>${_(u'Autor')}
            <strong>${comment.user.nickname}</strong>
            </label>
        </div>

        <div class="dataVision">
            <label>${_(u'Creado')}:
                <strong>${comment.created_on}</strong>
            </labelb>
        </div>


        <div class="dataVision">
            <label>${_(u'Contenido')}:
                <strong>${comment.content}</strong>
            </label>
        </div>

        </br></br>
        </br></br>

        %if c.user:
            %if comment.user_id == c.user.id:
                <div class="centerize">
                    <a href="/places/${comment.place_id}/comments/${comment.id}/edit"  
                        class='accion  bordeSoft'  style='text-transform: uppercase:' id='grande'>${_(u'Editar')}</a>
                    <a href="/places/${comment.place_id}/comments/${comment.id}/delete" 
                        class='accion  bordeSoft' style='text-transform: uppercase:' id='grande'>${_(u'Borrar')}</a>
                    </div>
            %endif
        %endif
    %endif
</%def>
