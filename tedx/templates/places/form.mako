<h2 class="mom">${_(u'Nueva Muestra')}</h2>	    

% if c.place_msg:
    <span class="error-message">${c.place_msg}</span><br />
% endif

<p><label for="name">${_(u'Description')}:</label><br>
${ h.text('name', value=c.name_value, size=64) }</p>
         
<p><label for="ph">${_(u'pH')}</label><br>
${ h.text('ph', size=3) }</p>

<p><label for="chlorine">${_(u'Cloro')}</label><br>
${ h.text('chlorine',size=3) }</p>

<p><label for="description">${_(u'Description')}:</label><br>
${ h.text('description', size=256) }</p>

<p><label for="imagen">${_(u'Imagen')}:</label><br>
${h.file('imagen')}

<p>

        ##<h2 class="mom">${_(u'Nueva Muestra')}</h2>	    
        
        ##    <input type="text" id="new-instant-txtName" name="new-instant-txtName"></input></label><br />

        ##<label for="new-instant-txtValuePH">${_(u'pH')}:<br />
        ##    <input type="text" id="new-instant-txtValuePH" class="mask-num" name="new-instant-txtValuePH"></input></label><br />

        ##<label for="new-instant-txtValueCloro">${_(u'Cloro')}:<br />
        ##    <input type="text" id="new-instant-txtValueCloro" class="mask-num" name="new-instant-txtValueChlorine"></input></label><br />

        ##<label for="new-instant-txtDescription">${_(u'description')}:</br>
        ##    <textarea id="new-instant-txtDescription" name="new-instant-txtDescription"></textarea></label>
        ##<div class="clear"></div>
        ##<br />
        ##<div>
        ##    <img src="/images/iconoFotografia.png" alt="Añadir imagen" /> <label>${_(u'image')}:</label>
        ##    <input size="12" type="file" id="new-instant-image" name="new-instant-image" /> 
        ##</div>
