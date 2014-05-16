<%inherit file="base_information.mako"/>
<%def name="title()">
    ${_(u'Cómo realizar la toma')}
</%def>

<%def name="contain()">
    <a class="titulo1">${_(u'Realización de la toma')}</a>
    </br></br>
    <a class="text">
        ${_(u'A continuación detallamos los pasos para realizar una correcta toma de las muestras')}

        </br></br>
        <b>${_(u'pH')}:</b>
        <ul>
            <li>${_(u'Deja salir agua del grifo (fría) unos 5 segundos aproximadamente')}.</li>
            <li>${_(u'Coge un poco de agua en un vaso de tu casa')}.</li>
            <li>${_(u'Introduce la tira medidora de pH en el agua durante 2 segundos')}-</li>
            <li>${_(u'Espera 5 segundos y compara el color de la tira medidora con el de la leyenda')}.</li>
            <li>${_(u'Anota el resultado obtenido')}.</li>
        </ul>
        </br></br>

        <b>${_(u'Cloro')}:</b>
        <ul>
            <li>${_(u'Deja salir agua del grifo (fría) unos 5 segundos aproximadamente')}.</li>
            <li>${_(u'Llena el recipiente de vidrio que te proporcionamos hasta que falte un dedo aproximadamente hasta el borde')}.</li>
            <li>${_(u'Introduce una pastilla')}.</li>
            <li>${_(u'Tapa inmediatamente el recipiente con el tapón y agita hasta que la pastilla esté totalmente disuelta')}.</li>
            <li>${_(u'Compara el color del agua del recipiente con el disco de colores')}.</li>
            <li>${_(u'Anota el valor obtenido')}.</li>
        </ul>
    </a>

    <div class="derecha">
        <a href="/information/stabilizer" class='accion bordeSoft' >${_(u'Anterior')}</a>
    </div>

</%def>

