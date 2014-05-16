# -*- coding: utf-8 -*-
<%inherit file="base_information.mako"/>

<%def name="title()">
    ${_(u'Mecanismo de Acción')}
</%def>

<%def name="contain()">
        <a class="titulo1">${ _(u'Mecanismo de acción')}</a>
        </br></br>
        <a class="text">
        ${ _(u'La acción desinfectante se produce por su capacidad de traspasar la pared celular del patógeno y atacar su sistema enzimático, provocando la muerte del organismo')}.
        </br>
        ${ _(u'Los compuestos de cloro, agentes desinfectante son el ácido hipocloroso (HOCl) y el ión hipoclorito (OCl-). Sin embargo, la desinfección es más eficiente con niveles de pH bajos debido a que favorece la formación de ácido hipocloroso, un agente alrededor de 80 veces más eficaz que el ión hipoclorito')}.
        </br>
        ${ _(u'Uno de los compuestos de cloro que ampliamente se utiliza es el hipoclorito de sodio, NaClO')}
        </br>
        ${_(u'Al adicionar la sal al agua se produce el ácido hipocloroso activo')}:
        </br>
        ${_(u'El ácido hipocloroso, se disocia en iones hidrógeno e iones hipoclorito en la siguiente reacción reversible')}:
        </br>
        ${_(u'En la reacción se producen iones H+')}:
        <ul>
            <li>${_(u'Si el pH del agua es bajo, es decir, hay mayor [H+], el equilibrio se desplaza hacia la izquierda, hacia el ácido hipocloroso, con lo que será mayor el poder de desinfección')}</li>
            <li>${_(u'Si el pH del agua es alto, es decir, hay menor [H+], el equilibrio se desplaza hacia la derecha, hacia el ion hipoclorito, con lo que el poder de desinfección será menor')}.</li>
        </ul>
        <br></br>
        ${_(u'La gráfica muestra la influencia del pH en la disociación del ácido hipocloroso para aguas con temperaturas entre 0 y 20 ºC. Se puede observar que para valores de pH superiores a 6, disminuye la cantidad de HOCl y aumenta el ion ClO-')}.
        </br>
        ${_(u'Ej. Por ejemplo, para un pH de 8, se tiene cerca de 22% de HOCl y 78% de ClO-')}.
        ${_(u'Nivel de cloro adecuado en agua de consumo humano')}
        ${_(u'Visto esto ya se puede interpretar que en todo sistema de desinfección basado en cloro / hipoclorito es imprescindible disponer de un control sobre el valor del pH a fin de garantizar su eficacia desinfectante')}.
        ${_(u'Para calificar un agua como APTA o NO APTA para el consumo humando se deben cumplir todos los requisitos mínimos, parámetros indicadores (Real Decreto 140/2003), entre ellos el nivel de cloro y de pH, que son los incluidos en MapClor')}.
        </a>
</%def>
