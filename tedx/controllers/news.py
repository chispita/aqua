from functions import *
from webhelpers import paginate

from tedx.lib.base import *
from pylons.i18n import _

import logging
log = logging.getLogger(__name__)

class NewsController(BaseController):

    def _base(self):
        page = 1
        if request.GET.has_key('page'):
            page = request.GET['page']

        c.ListPlaces = paginate.Page(
            getLastPlaces(),
            page = page,
            items_per_page=5)

        page = 1

    def index(self):
        self._base()
        return render('/news/unizar.mako')

    def unizar_boletin_30_5_2014(self):
        self._base()
        return render('/news/unizar.mako')

    def video_tutorial_01(self):
        self._base()
        return render('/news/video1.mako')
