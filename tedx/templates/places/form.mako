%if c.form is 'edit':
    ${ h.hidden('place.id', size=40) }
%endif

${ h.hidden('place.latitude') }</p>
${ h.hidden('place.longitude')}</p>

<p><label for="place.name">${_(u'Nombre')}</label>
    ${ h.text('place.name', size=40) }
         
<p><label for="ph">${_(u'pH')}</label><br>
    ${ h.text('place.ph', size=3) }</p>

<p><label for="chlorine">${_(u'Cloro')}</label><br>
    ${ h.text('place.chlorine',size=3) }</p>

<p><label for="description">${_(u'Description')}:</label><br>
    ${ h.text('place.description', size=256) }</p>


<p><label for="imagen">${_(u'Imagen')}:</label><br>
    ${ h.file('place.image', size=50)}
    <p>

