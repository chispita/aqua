# -*- coding: utf-8 -*-

import os

from tedx.lib.base import *
from pylons.i18n import _

import math, cgi
import shutil
import Image
import datetime

import logging
log = logging.getLogger(__name__)

from sqlalchemy import and_

from geopy import geocoders
from pygeocoder import Geocoder


def getLocation( latitude, longitude):
    ''' Get data address data from latitude and longitude '''
    function = 'getLocation'
    address = ''
    city = ''
    postalcode = ''
    country = ''
    g = geocoders.GoogleV3()
    log.debug(function)

    try:
        point = '%.6f, %6f' % (latitude, longitude)

        positions = g.reverse( point )
        if positions:
            data, (latitude, longitude)  = positions[0]
            results = Geocoder.geocode(data)

            address = results[0].route
            if results[0].street_number:
                address = address + ',' + results[0].street_number
            country = results[0].country
            city =  results[0].city
            postalcode = results[0].postal_code
    except:
        pass

    return address, city, postalcode, country


''' Users '''
def getAllUsers():
    ''' Get all the users active '''
    return meta.Session.query(User).filter(User.deleted_on==None).order_by(desc(User.created_on))

''' Profile '''
def getProfilePlaces(nickname):
    ''' Get places of the user '''
    return meta.Session.query(Place).filter(and_(Place.user.has(User.nickname == nickname), Place.deleted_on==None))

def getProfileComments(nickname):
    ''' Get Comments of the user '''
    return meta.Session.query(Comment).filter(and_(Comment.user.has(User.nickname == nickname), Place.deleted_on==None ))

''' Places '''
def getAllPlaces():
    ''' Get the all drops saved '''
    return meta.Session.query(Place).filter(and_(Place.empty==False, Place.deleted_on==None))

def getLastPlaces():
    ''' Get the last drops saved '''
    return meta.Session.query(Place).filter(and_(Place.empty==False, Place.deleted_on==None)).order_by(desc(Place.last_update))

''' Comments '''
def getAllComments():
    ''' Get all comments saved '''
    return meta.Session.query(Comment).filter(Comment.deleted_on==None).order_by(desc(Comment.last_update))

def getCommentsPlace(id):
    ''' Get Comments in a place '''
    return meta.Session.query(Comment).filter(and_(Comment.place_id==id,Comment.deleted_on==None)).order_by(desc(Comment.last_update))


def UploadFile(db_comment, attachment):
    ''' Save attachment in the system
        and save the root in the comment associated
    '''
    function = 'UploadFile'
    log.debug(function)

    # Grabacion de la imagen
    name = attachment.filename

    folder = c.user.id.lstrip(os.sep)
    if not os.path.isdir(os.path.join(os.getcwd(), 'tedx/public/files/', folder)):
        os.mkdir(os.path.join(os.getcwd(), 'tedx/public/files/', folder))

    db_file = db_comment.add_file('image', attachment.filename)
    full_path = os.path.join(os.getcwd(), 'tedx/public/files/', folder, db_file.id)
    db_file.path = os.path.join('/files', folder, db_file.id)
    db_file.size = len(attachment.value)
    permanent_file = open(full_path, 'w')

    shutil.copyfileobj(attachment.file, permanent_file)
    attachment.file.close()
    permanent_file.close()

    try:
        im = Image.open(os.path.join(os.getcwd(),'tedx/public/files/', folder, db_file.id.lstrip(os.sep)))
    except Exception, e:
        os.remove(os.path.join(os.getcwd(),'tedx/public/files/', folder, db_file.id.lstrip(os.sep)))
        meta.Session.delete(db_file)
        meta.Session.commit()

        #h.flash(_(u'El archivo enviado no es una imagen valida'))
        return

    im = im.convert('RGB')
    width, height = im.size
    filename = db_file.id + '.jpg'
    filenamemid = db_file.id + '_mid.jpg'
    filenamemini = db_file.id + '_small.jpg'
    out = im
    outmid = im
    outmini = im
    imAspect = float(width)/float(height)

    # Default
    if width > app_globals.default_image_size or height > app_globals.default_image_size:
        if width > height:
            out = im.resize((app_globals.default_image_size,int(float(app_globals.default_image_size) / imAspect)), Image.ANTIALIAS)
        else:
            out = im.resize((int(float(app_globals.default_image_size) * imAspect),app_globals.default_image_size), Image.ANTIALIAS)

    # Imagen de tamaño medio
    if width > app_globals.mid_image_size or height > app_globals.mid_image_size:
        if width > height:
            outmid = im.resize((app_globals.mid_image_size,int(float(app_globals.mid_image_size) / imAspect)), Image.ANTIALIAS)
        else:
            outmid = im.resize((int(float(app_globals.mid_image_size) * imAspect),app_globals.mid_image_size), Image.ANTIALIAS)

    # Imagen de tamaño pequeño
    if width > app_globals.small_image_size or height > app_globals.small_image_size:
        if width > height:
            outmini = im.resize((app_globals.small_image_size,int(float(app_globals.small_image_size) / imAspect)), Image.ANTIALIAS)
        else:
            outmini = im.resize((int(float(app_globals.small_image_size) * imAspect),app_globals.small_image_size), Image.ANTIALIAS)

    out.save(os.path.join(os.getcwd(),'tedx/public/files/', folder, filename.lstrip(os.sep)))
    outmid.save(os.path.join(os.getcwd(),'tedx/public/files/', folder, filenamemid.lstrip(os.sep)))
    outmini.save(os.path.join(os.getcwd(),'tedx/public/files/', folder, filenamemini.lstrip(os.sep)))
    os.remove(os.path.join(os.getcwd(),'tedx/public/files/', folder, db_file.id.lstrip(os.sep)))

    meta.Session.add(db_file)
    meta.Session.commit()
