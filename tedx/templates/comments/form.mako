<p><label for="name">${_(u'Titulo')}:</label><br>
    ${ h.text('comment.title', size=50) }    
</p>

<p><label for="name">${_(u'Descrición')}:</label><br>
    ${ h.textarea('comment.content', size=256) }    
</p>
<p><label for="imagen">${_(u'Adjunto')}:</label><br>
    ${ h.file('comment.image', size=50) }
<p>

Id${h.text('comment.id')}
Place Id${h.text('comment.place_id')}


