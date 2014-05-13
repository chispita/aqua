<p><label for="name">${_(u'Nombre')}:</label><br>
    ${ h.text('register.name', size=50) }    
</p>

<p><label for="email">${_(u'Email')}:</label><br>
    ${ h.text('register.email', size=50) }    
</p>

<p><label for="password">${_(u'Contraseña')}:</label><br>
    ${ h.password("register.password", size=15) }
</p>

<p><label for="password-verify">${_(u'Verifique la contraseña')}:</label><br>
    ${ h.password("register.password2", size=15) }
</p>


