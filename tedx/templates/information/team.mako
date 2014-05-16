## team.mako ## 
<%inherit file="base_information.mako"/>

<%def name="title()">
    ${_(u'Equipo')}
</%def>

<%def name="contain()">
    <a class="titulo1">${_(u'Equipo')}</a>
        </br></br>
        <a class="text">
        ${_(u'Para este proyecto, Ibercivis se beneficia de la experiencia de este grupo de profesionales')}:
        </br></br>
        <b>${_(u'Francisco Sanz')}</b>, ${_(u'tiene relación directa con la comunidad científica para brindarles la plataforma Ibercivis que permite contactar  con la ciudadanía y la ciencia ciudadana. Desarrollador de herramientas para este nuevo tipo de ciencia. Divulgador en distintos foros acerca    de computación y ciencia ciudadana')}.
        </br></br>

        <b>${_(u'Carlos Val')}</b> ${_(u'es desarrollador de infraestructuras de ciencia ciudadana. Encargado de las relaciones con entidades externas para desarrollar proyectos de ciencia ciudadana')}.
        </br></br>
        <b>${_(u'Eduardo Lostal Lanza')}</b> ${_(u'es desarrollador de aplicaciones web y móvil para proyectos de ciencia ciudadana. Presente en distintos      congresos relacionados con el ámbito de la ciencia ciudadana. Director de proyectos fin de carrera relacionados con ciencia ciudadana')}.
        </br></br>
        <b>${_(u'M.Carmen Ibáñez Hernández')}</b> ${_(u'es encargada de la sección de divulgación y difusión dentro de la fundación así como organizadora de    eventos de ciencia ciudadana, cuenta con 5 años de experiencia desarrollando actividades con la ciudadanía')}.
   <br />
   </a>

</%def>
