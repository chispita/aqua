import sqlalchemy as sa
import datetime
import string
from random import choice, uniform
from sqlalchemy.databases import mysql

from tedx.model import meta
from tedx.model.comment import Comment
from tedx.model.tag import Place_tag
from tedx.model.scoring import Place_scoring

from tedx.lib.app_globals import generate_id
from sqlalchemy import and_

place_table = sa.Table("Places",meta.metadata, mysql_engine='MyISAM')
place_table.append_column(sa.Column("id", mysql.MSString(16, collation="utf8_bin"), primary_key=True, default=generate_id))
place_table.append_column(sa.Column("user_id", sa.ForeignKey('Users.id'), nullable=False))
place_table.append_column(sa.Column("longitude", sa.types.Numeric(9,6)))
place_table.append_column(sa.Column("latitude", sa.types.Numeric(8,6)))
place_table.append_column(sa.Column("name", sa.types.String(64)))
place_table.append_column(sa.Column("visits", sa.types.Integer))
place_table.append_column(sa.Column("empty", sa.types.Boolean, default=False))
place_table.append_column(sa.Column("created_on", sa.types.DateTime))
place_table.append_column(sa.Column("deleted_on", sa.types.DateTime))
place_table.append_column(sa.Column("city", sa.types.String(128)))
place_table.append_column(sa.Column("country", sa.types.String(128)))
place_table.append_column(sa.Column("last_update", sa.types.DateTime))
place_table.append_column(sa.Column("ph", sa.types.Numeric(2,1)))
place_table.append_column(sa.Column("chlorine", sa.types.Numeric(3,1)))
place_table.append_column(sa.Column("address", sa.types.String(256)))
place_table.append_column(sa.Column("postalcode", sa.types.String(50)))
place_table.append_column(sa.Column("take_on", sa.types.DateTime))
place_table.append_column(sa.Column("description", sa.types.String(256)))

class Place(object):
    def __init__(self, user, latitude, longitude, name, address=None, city=None, postalcode=None, country=None, description=None, take_on=None):
        self.id = generate_id(self)
        while meta.Session.query(Place).filter_by(id = self.id).first() != None:
            self.id = generate_id(self)
        self.user = user
        self.latitude = round(float(latitude),6)
        self.longitude = round(float(longitude),6)
        self.name = name
        self.description = description
        self.address = address
        self.postalcode=postalcode
        self.visits = 0
        self.city = city
        self.country = country
        self.created_on = datetime.datetime.now()
        self.last_update = datetime.datetime.now()
        if take_on is None:
            self.take_on = datetime.datetime.now()
        else:
            self.take_on = take_on

    def remove(self):
        self.deleted_on = datetime.datetime.now()
        meta.Session.commit()

    def generate_password(self, max=16, chars=string.letters + string.digits):
        new_string = ''
        for i in range(max):
            new_string = new_string + choice(chars)
        return new_string

    def add_comment(self, user, content, title=None):
        db_comment = Comment(self, user, content, title)
        self.last_update = datetime.datetime.now()
        self.comments.append(db_comment)
        user.comments.append(db_comment)
        meta.Session.add(self)
        meta.Session.commit()
        return db_comment

    def add_scoring(self, user, value):
        existing_score = meta.Session.query(Place_scoring).filter(and_(Place_scoring.place_id == self.id,Place_scoring.user_id == user.id)).first()
        if not existing_score:
            db_scoring = Place_scoring(self, user, value)
            return db_scoring
        else:
            return None

    def add_tag(self, tag):
        db_tag = Place_tag(self, tag)
        return db_tag

    def add_visit(self):
        self.visits += 1
        meta.Session.commit()

    def add_water(self, ph, chlorine):
        self.ph = ph
        self.chlorine = chlorine
        meta.Session.commit()

    @classmethod
    def find_by_id(cls, id, abort_404 = False):
        result = meta.Session.query(Place).filter_by(id=id).first()
        if result is None and abort_404:
            abort(404, "No such place object")
        return result
