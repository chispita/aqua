## more information ##
<%inherit file="base_information.mako"/Map<%def name="title()">
    ${_(u'Análisi del Agua')}
</%def>

<%def name="contain()">
    <a class="titulo1">${_(u'Análisis del Agua')}</a>
        </br></br>
        <a class="text">
            
            ${_(u'El ayuntamiento de la la ciudad de Zaragoza realiza a través de su Instituto Municipal de Salud Pública un control de la calidad del agua periódico y los resultados analíticos pueden ser consultados')} <a href="http://www.zaragoza.es/ciudad/IMSP/sanidad/listado_IMSP"        target="blank">${_(u'aquí')}</a>. 
            
    <a class="text"> ${_(u'Este control se realiza según los parámetros definidos en el Real Decreto 140/2003 y sus modificaciones')}
 </br></br>

    <a class="text">
    ${_(u'Uno de los parámetros de control, cuyo nivel permite mantener “a raya” a los contaminantes microbiológicos es el cloro, incluso a        concentraciones muy bajas tiene una importante actividad biocida. Conservar los límites de concentración del clore en nuestros grifos, fuentes,  etc, estimados por legislación y suficientes para inhibir el crecimiento microbiano, es una tarea a veces no demasiado fácil.')}
    </br></br>
    ${_(u'Sería lógico suponer que un aumento en la concentración de cloro disponible en una solución traería un aumento correspondiente en la actividad biocida. Esta suposición puede ser verdad, mientras que otros factores, tales como el pH, la temperatura y el contenido de materia orgánica se mantengan constantes.')}
    </br></br>
    ${_(u'El poder biocida del cloro depende mucho de su no disociación en solución acuosa que está directamente relacionada al pH. Un aumento en el pH diminuye sustancialmente la actividad biocida del cloro, y una disminución del pH aumenta esa actividad en la misma proporción. Desde principios del siglo XX, se demostró esta dependencia del pH en la formación del ácido hipocloroso, forma más eficaz de la actividad biocida delos compuestos clorados, y por consiguiente, en la eficacia del cloro.')}
    </a>
</%def>

