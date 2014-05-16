# -*- coding: utf-8 -*-
<%inherit file="base_information.mako"/>

<%def name="title()">
    ${_(u'Información')}
</%def>

<%def name="contain()">
    <a class="titulo1">${_(u'Cloro como método de desinfección del agua de consumo')}</a>
        </br></br>
        <a class="text">${ _(u'El método de desinfección más aplicado en los sistemas de abastecimiento de agua, es el que emplea cloro en el tratamiento, garantizando la desinfección y la presencia de cloro en la red de distribución')}.</a>
            
        </br></br>
        <a class="text">
        ${ _(u'La finalidad principal de la cloración es destruir los microorganismos patógenos por la acción desinfectante del cloro, aunque también son importantes otros efectos secundarios como la oxidación del hierro, el manganeso y los sulfuros de hidrógeno, así como la destrucción de algunos compuestos que podrían aportar olores y sabores al agua')}
        </a>
        </br></br></br></br>
        <div class="derecha">
            <a href="/information/information2" class='accion bordeSoft' >${_(u'Siguiente')}</a>
        </div>


</%def>
