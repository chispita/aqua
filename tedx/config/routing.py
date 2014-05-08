"""Routes configuration

The more specific and detailed routes should be defined first so they
may take precedent over the more generic routes. For more information
refer to the routes manual at http://routes.groovie.org/docs/
"""
from routes import Mapper

def make_map(config):
    """Create, configure and return the routes Mapper"""
    map = Mapper(directory=config['pylons.paths']['controllers'],
                 always_scan=config['debug'])
    map.minimization = False
    map.explicit = False

    # The ErrorController route (handles 404/500 error pages); it should
    # likely stay at the top, ensuring it can always be resolved
    map.connect('/error/{action}', controller='error')
    map.connect('/error/{action}/{id}', controller='error')

    # CUSTOM ROUTES HERE

    #map.connect('/', controller='home', action='index')

    # Account
    #map.connect('/account/{nickname}', controller='account', action='profile')

    # Places

    map.connect('/',                            controller='home',  action='index')

    # Links to Account Public Profiles
    map.connect('/account/{nickname}',          controller='account', action='public_profile')
    map.connect('/account/{nickname}/comments/',controller='account', action='comments')
    map.connect('/account/{nickname}/visits/',  controller='account', action='visits')

    # Link to Account Private Profile
    map.connect('/account/profile/',             controller='account', action='profile' )
    map.connect('/account/settings/',            controller='account', action='settings' )



    #map.connect('/account/signin',              controller='account', action='signin')
    #map.connect('/account/signout',             controller='account', action='signout')
    #map.connect('/account/forgotten_password',  controller='account', action='forgotten_password'

    map.connect('/places/new',                  controller='places',  action='new')
    map.connect('/places/save',                 controller='places',  action='save')
    map.connect('/places/{id}/edit',            controller='places',  action='edit')
    map.connect('/places/{id}/delete',          controller='places',  action='delete')
    map.connect('/places/{id}',                 controller='places',  action='detail')

     # Schedule
     #map.connect('/programme/schedule',                controller='schedule', action='table', day=None)
     #map.connect('/programme/schedule/ical',           controller='schedule', action='ical')
     #map.connect('/programme/schedule/json',           controller='schedule', action='json')
     #map.connect('/programme/schedule/{day}',          controller='schedule', action='table', day=None)
     #map.connect('/programme/schedule/view_talk/{id}', controller='schedule', action='table_view', id=None)
     #map.connect('/programme/schedule/video',          controller='schedule', action='video_room', room=None)
     #map.connect('/programme/schedule/video/{room}',   controller='schedule', action='video_room', room=None)
     #map.connect('/event/new_proposals',               controller='event', action='new_proposals')



    map.connect('/{controller}', action='index')
    map.connect('/{controller}/', action='index')
    map.connect('/{controller}/{action}')
    map.connect('/{controller}/{action}/{id}')

    map.connect('/{nickname}',        controller='profile', action='view')
    #map.connect('/account/{nickname}', controller='account', action='profile')

    #map.connect('/data/list',         controller='list', action='index')
    #map.connect('/data/list/{id}',    controller='list', action='view')

    return map
