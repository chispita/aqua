# -*- coding: utf-8 -*-
<%inherit file="common.mako"/>
<%def name="title()">
    ${_(u'Debes Logearte')}
</%def>

<%def name="head()">
    <link rel="stylesheet" type="text/css" href="/css/my_account.css" />

</%def>
<%def name="init()"></%def>


<%def name="MainContent()">

    <div id="MsgOverMap">

        <div align="right"><a href="/" class="close-icon"></a></div>

        <h2>${_(u'Cloro como método de desinfección del agua de consumo')}</h2>
        <br>
        ${ _(u'El método de desinfección más aplicado en los sistemas de abastecimiento de agua, es el que emplea cloro en el tratamiento, garantizando la desinfección y la presencia de cloro en la red de distribución')}.
        </br></br>
        ${ _(u'La finalidad principal de la cloración es destruir los microorganismos patógenos por la acción desinfectante del cloro, aunque también son importantes otros efectos secundarios como la oxidación del hierro, el manganeso y los sulfuros de hidrógeno, así como la destrucción de algunos compuestos que podrían aportar olores y sabores al agua')}

        <h2>${ _(u'Mecanismo de acción')}</h2>
        ${ _(u'La acción desinfectante se produce por su capacidad de traspasar la pared celular del patógeno y atacar su sistema enzimático, provocando la muerte del organismo')}.
        </br></br>
        ${ _(u'Los compuestos de cloro, agentes desinfectante son el ácido hipocloroso (HOCl) y el ión hipoclorito (OCl-). Sin embargo, la desinfección es más eficiente con niveles de pH bajos debido a que favorece la formación de ácido hipocloroso, un agente alrededor de 80 veces más eficaz que el ión hipoclorito')}.
        </br></br>
        ${ _(u'Uno de los compuestos de cloro que ampliamente se utiliza es el hipoclorito de sodio, NaClO')}
        </br></br>
        ${_(u'Al adicionar la sal al agua se produce el ácido hipocloroso activo')}:
        </br></br>
        ${_(u'El ácido hipocloroso, se disocia en iones hidrógeno e iones hipoclorito en la siguiente reacción reversible')}:
        </br></br>
        ${_(u'En la reacción se producen iones H+')}:
        <ul>
            <li>${_(u'Si el pH del agua es bajo, es decir, hay mayor [H+], el equilibrio se desplaza hacia la izquierda, hacia el ácido hipocloroso, con lo que será mayor el poder de desinfección')}</li>
            <li>${_(u'Si el pH del agua es alto, es decir, hay menor [H+], el equilibrio se desplaza hacia la derecha, hacia el ion hipoclorito, con lo que el poder de desinfección será menor')}.</li>
        </ul>
        <br></br>
        ${_(u'La gráfica muestra la influencia del pH en la disociación del ácido hipocloroso para aguas con temperaturas entre 0 y 20 ºC. Se puede observar que para valores de pH superiores a 6, disminuye la cantidad de HOCl y aumenta el ion ClO-')}.
        </br></br>
        ${_(u'Ej. Por ejemplo, para un pH de 8, se tiene cerca de 22% de HOCl y 78% de ClO-')}.
        ${_(u'Nivel de cloro adecuado en agua de consumo humano')}
        ${_(u'Visto esto ya se puede interpretar que en todo sistema de desinfección basado en cloro / hipoclorito es imprescindible disponer de un control sobre el valor del pH a fin de garantizar su eficacia desinfectante')}.
        ${_(u'Para calificar un agua como APTA o NO APTA para el consumo humando se deben cumplir todos los requisitos mínimos, parámetros indicadores (Real Decreto 140/2003), entre ellos el nivel de cloro y de pH, que son los incluidos en MapClor')}.
    </div>

</%def>  
                
<%def name="content()">
    <div class="sidebarIzq">
        <%include file="information_teachers.mako"/>
    </div>
                                                                  
    <div class="content_center">
        <h3>${_(u'Muestra de Agua Analizadas')}</h3>
        <div id="list"></div>
            <div id="srToolsDown"></div>
        </div>
                                                                    
        <div class="sidebarDer">
            <%include file="datos.mako"/>
        </div>
</%def>

