<p><label for="name">${_(u'Titulo')}:</label><br>
    ${ h.text('comment.title', size=50) }    
</p>

<p><label for="name">${_(u'Descrición')}:</label><br>
    ${ h.textarea('comment.content', size=256) }    
</p>
<p><label for="imagen">${_(u'Adjunto')}:</label><br>
    ${ h.file('comment.image', size=50) }
<p>

${h.hidden('comment.id')}
${h.hidden('comment.place_id')}
