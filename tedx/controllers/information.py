from tedx.lib.base import *
from pylons.i18n import _

import logging
log = logging.getLogger(__name__)

class InformationController(BaseController):

    def index(self):
        return render('/information.mako')
