From: ${ h.lca_info['event_name'] } <${ h.lca_info['contact_email'] }>
Subject: ${ h.event_name() } Error en el sistema
To: ${ c.email }


    Se ha proucido un error en el servidor: ${ h.event_name() } 

    Tipo: ${ c.error_number }
    Codigo: ${c.error_code }
    Mensaje: ${ c.error_message }


El equipo de:  ${ h.event_name() }
