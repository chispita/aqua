<a class="text">${_(u'Nombre')}<a></br>
${ h.text('register.name', size=50) }</br>    

<a class="text">${_(u'Email')}</a></br>
${ h.text('register.email', size=50) }</br>

<a class="text">${_(u'Contraseña')}</a></br>
${ h.password("register.password", size=15) }</br>

<a class="text">${_(u'Verifique la contraseña')}</a><br>
${ h.password("register.password2", size=15) }


