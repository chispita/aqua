<%inherit file="base_information.mako"/>
<%def name="title()">
    ${_(u'Potabilización')}
</%def>

<%def name="contain()">
    <a class="titulo1">${_(u'Potabilización')}</a>
    </br></br>
    <a class="text">
        ${_(u'Un proceso de potabilización permite adecuar la calidad de un agua natural para que pueda ser consumida por el ser humano sin que tenga efectos nocivos para la salud')}.
        </br></br>
        ${_(u'Una de las fases más importantes del proceso de potabilización es la desinfección. En la actualidad la desinfección se lleva a cabo con compuestos derivados del cloro lo que permite la eliminación de los gérmenes patógenos que puede contener el agua de modo que cuando la consumamos no nos haga ningún daño. Por esta razón es necesario que el agua que sale de nuestros grifos contenga una pequeña cantidad de cloro lo cual garantizará la desinfección de la misma')}.
    </a>

    <div class="derecha">
        <a href="/information/analysis" class='accion bordeSoft' >${_(u'Anterior')}</a>
        <a href="/information/process" class='accion bordeSoft' >${_(u'Siguiente')}</a>
    </div>

</%def>


