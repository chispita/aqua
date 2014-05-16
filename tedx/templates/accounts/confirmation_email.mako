From: ${ h.lca_info['event_name'] } <${ h.lca_info['contact_email'] }>
Subject: ${ h.event_name() } Confirmación de reinicio de contraseña 
To: ${ c.email }

%if c.person is not None:
    Se ha procedido a resetar la contraseña para el servidor: ${ h.event_name() } 

    Nueva contraseña: ${c.password}

##${ h.url_for(qualified=True, controller='person', action='reset_password', url_hash=c.conf_rec.url_hash) }
    
##    Tenga en cuenta que esta URL expirará después de 24 horas

    Si no solicito esta acción, puede ignorar este mensaje.

%else:
    Alguien, posiblemente usted, ha solicitado resetar las contrasñea para ${ h.event_name() }.

    Aún asi, no parece tener una cuenta para este sitio. 

##  ${ h.url_for(qualified=True, controller='person', action='new') }

    Si no solicito esta acción, puede ignorar este mensaje.
%endif

El equipo de:  ${ h.event_name() }
