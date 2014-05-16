from functions import *
from webhelpers import paginate

from tedx.lib.base import *
from pylons.i18n import _

import logging
log = logging.getLogger(__name__)

class InformationController(BaseController):

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
        return render('/information/information.mako')

    def information2(self):
        self._base()
        return render('/information/information2.mako')

    def analysis(self):
        self._base()
        return render('/information/moreinformation.mako')

    def team(self):
        self._base()
        return render('/information/team.mako')
