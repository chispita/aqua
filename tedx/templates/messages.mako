## messages.mako ##
<% messages = h.get_flashes() %>

% if messages:
    <div id="notification">
        <p>
        % for (category, msgs) in messages.iteritems():
            <a id="message_text">
            % if len(msgs) is 1:
                <p>${ msgs[0] | n }</p>
            % else:
                % for msg in msgs:
                    ${ msg | n }<br>
                % endfor
            % endif
            </a>
        % endfor
        </p>

        <a href="/" class="close-icon"></a>

    </div>
% endif

