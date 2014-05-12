# -*- coding: utf-8 -*-
import os

from tedx.lib.base import *
from pylons.i18n import _

import math, cgi

import logging
log = logging.getLogger(__name__)

from sqlalchemy import and_

'''
def get_drop_status(ph, chlorine):
    if ph >= 6:
        return 1
    elif ph >=4:
        return 2
    else:
        return 3

def get_drop_image(value):
    if value==1:
        return  '/images/drop_blue.png'
    elif value==2:
        return  '/images/drop_green.png'
    else:
        return  '/images/drop_brown.png'
'''

''' Users '''
def getAllUsers():
    ''' Get all the users active '''
    return meta.Session.query(User).filter(User.deleted_on==None)

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
