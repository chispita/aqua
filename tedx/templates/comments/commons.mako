<%namespace name="functions"  file="/functions.mako"/>

<%def name="show_comment(comment)">
    %if comment:
        <div align="right"><a href="/" class="close-icon"></a></div>

        <h2>${comment.title}</h2>

        <h3>${_(u'Descripción')}</h3>

        <div class="dataVision">
            <label>${_(u'Autor')}</label>
            ${comment.user_id}
        </div>

        <div class="dataVision">
            <label>${_(u'Creado')}:</label>
            ${comment.created_on}
        </div>


        <div class="dataVision">
            <label>${_(u'Contenido')}:</label>
            ${comment.content}
        </div>

        <br><br>
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
