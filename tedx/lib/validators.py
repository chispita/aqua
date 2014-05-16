import formencode
from formencode import validators, Invalid #, schema

class BaseSchema(formencode.Schema):
    allow_extra_fields = True
    filter_extra_fields = True
