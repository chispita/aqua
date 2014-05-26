<a class="text">${_(u'Titulo')}:</a></br>
${ h.text('comment.title', size=50) }</br>

<a class="text">${_(u'Descrición')}:</a><br>
${ h.textarea('comment.content', size=256) }</br>

<a class="text">${_(u'Adjunto')}:</a><br>
${ h.file('comment.image', size=50) }

