${ h.hidden('place.latitude') }</p>

<a class="text">${_(u'Nombre')}</a></br>
${ h.text('place.name', size=40) }</br>

<a class="text">${_(u'Fecha de la muestra')}</a></br>
${ h.text('place.date', size=10) }</br>

<a class="text">${_(u'Hora de la muestra')}</a></br>
${ h.text('place.time', size=5) }</br>
<a class="text">${_(u'pH')}</a></br>
${ h.text('place.ph', size=2, class_="mask-int") }</br>

<a class="text">${_(u'Cloro')}(punto decimal: e.g.:1.2)</a></br>
${ h.text('place.chlorine',size=3, class_="mask-num") }</br>

<a class="text">${_(u'Description')}</a></br>
${ h.textarea('place.description', size=256) }</br>

<a class="text">${_(u'Imagen')}</a></br>
${ h.file('place.image', size=50)}</br>

${ h.hidden('place.longitude')}
