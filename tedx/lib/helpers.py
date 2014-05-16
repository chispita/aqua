"""Helper functions

Consists of functions to typically be used within templates, but also
available to Controllers. This module is available to templates as 'h'.
"""
# Import helpers as desired, or define your own, ie:
#from webhelpers.html.tags import checkbox, password

import simplejson
from routes import url_for
from webhelpers.html.tags import link_to

from webhelpers.html.tags import *
from webhelpers.html.tags import file

from pylons import session
from sqlalchemy.orm.util import object_mapper

from tedx.config.lca_info import lca_info

def toJSON(obj):
    return simplejson.encoder.JSONEncoder(use_decimal=True, sort_keys=True, encoding="utf-8").encode(obj)

def generate_vcard(user, path, size):
    enc = Encoder()
    w = size

    vcard_text = "BEGIN:VCARD\n" + \
    "VERSION:3.0\n" + \
    "N:" + user.nickname + "\n" + \
    "EMAIL;TYPE=PREF,INTERNET:" + user.email + "\n"

    if user.name or user.surnames:
        vcard_text += "FN:"
        if user.name:
            vcard_text += user.name
        if user.surnames:
            vcard_text += " " + user.surnames
        vcard_text += "\n"

    if user.description:
        vcard_text += "NOTE:" + user.description + "\n"

    if user.address or user.city or user.country:
        vcard_text += "ADR:"
        if user.address:
            vcard_text += user.address
        if user.city:
            vcard_text += " " + user.city
        if user.country:
            vcard_text += " " + user.country
        vcard_text += "\n"

    vcard_text += "END:VCARD"

    qr = enc.encode(vcard_text.encode("utf8"), {'width': w, 'mode': 2})
    qr.save(path)


def check_flash():
    """If the session data isn't of the particular format python has trouble.
    So we check that it is a dict."""
    if session.has_key('flash'):
        if type(session['flash']) != dict:
            del session['flash']
            session.save()

def get_flashes():
    check_flash()
    if not session.has_key('flash'):
        return None
    messages = session['flash']
    # it is save to delete now
    del(session['flash'])
    session.save()
    return messages


def flash(msg, category="information"):
    check_flash()
    if not session.has_key('flash'):
        session['flash'] = {}
    if not session['flash'].has_key(category):
        session['flash'][category] = []
    session['flash'][category].append(msg)
    session.save()

def object_to_defaults(object, prefix):
    defaults = {}

    for key in object_mapper(object).columns.keys():
        value = getattr(object, key)
        if type(value) == list:
            for code in value:
                defaults['.'.join((prefix, key, code))] = 1
                defaults['.'.join((prefix, key))] = ','.join(value)
        elif value == True:
            defaults['.'.join((prefix, key))] = 1
        else:
            defaults['.'.join((prefix, key))] = value

    return defaults

def webmaster():
    return lca_info['webmaster_email']

def webmaster_email(text=None):
    """ E-mail link for the conference contact.
    Renders a link to the committee; optionally takes a text, which will be
    the text of the anchor (defaults to the e-mail address).
    """
    email = lca_info['webmaster_email']
    if text == None:
        text = email

    return link_to(text, 'mailto:' + email)

def contact_email(text=None):
    """ E-mail link for the conference contact.

    Renders a link to the committee; optionally takes a text, which will be
    the text of the anchor (defaults to the e-mail address).
    """
    email = lca_info['contact_email']
    if text == None:
        text = email

    return link_to(text, 'mailto:' + email)

def event_name():
    """ Name of the event
    Returns the name of the event we're running (yay).
    """
    return lca_info['event_name']
