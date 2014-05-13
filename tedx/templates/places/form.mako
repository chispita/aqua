%if c.form is 'edit':
    ${ h.hidden('place.id', size=40) }
%endif

${ h.hidden('place.latitude', hide=True) }</p>
${ h.hidden('place.longitude', hide=True)}</p>

<label for="place.name">${_(u'Nombre')}</label></p>                                                 
<p class="entries">${ h.text('place.name', size=40) }</p>    
         
<p><label for="ph">${_(u'pH')}</label><br>
    ${ h.text('place.ph', size=3) }</p>

<p><label for="chlorine">${_(u'Cloro')}</label><br>
    ${ h.text('place.chlorine',size=3) }</p>

<p><label for="description">${_(u'Description')}:</label><br>
    ${ h.text('place.description', size=256) }</p>


<p><label for="imagen">${_(u'Imagen')}:</label><br>
    ${ h.file('place.image', size=50)}
<p>

${ h.hidden('place.longitude', hide=True)}</p>

