#!/usr/bin/env python

import asyncio

import tornado.escape
import tornado.httpclient
import tornado.ioloop
import tornado.options
import tornado.platform.asyncio
import tornado.queues
import tornado.web

import faker

import contextlib
import datetime
import glob
import json
import re
import sqlite3
import time

CATALOG_NUM_PAGES = 10
DATABASE = None


@contextlib.contextmanager
def database():
    global DATABASE

    if DATABASE is None:
        DATABASE = sqlite3.connect(':memory:')
        DATABASE.execute(('CREATE TABLE catalog ('
                          '  facility, instrument, experiment, run, data '
                          ')'))
        DATABASE.commit()

    yield DATABASE

class IndexHandler(tornado.web.RequestHandler):
    def initialize(self):
        self.set_header('cache-control', 'no-cache')

    @tornado.gen.coroutine
    def get(self):
        while True:
            with open(tornado.options.options.status, 'r') as f:
                status = json.load(f)

            if status["status"] == "done":
                break

            yield tornado.gen.sleep(0.1)

        self.render('index.html', assets=tornado.options.options.assets)

class CatalogPageHandler(tornado.web.RequestHandler):
    @tornado.gen.coroutine
    def get(self, page):
        page = int(page)

        if page < 0 or page > CATALOG_NUM_PAGES:
            self.set_status(404)
            self.write(dict(
                status="error",
                data=None,
                message="Invalid index (expected 0 < page <= {})".format(
                    CATALOG_NUM_PAGES,
                ),
            ))
            return

        fake = faker.Faker()
        fake.seed(page)

        entries = []
        for _ in range(10):
            run = fake.pyint()
            title = fake.sentence(nb_words=2)
            proton_charge = fake.pyfloat(),
            start_time = fake.date_time_this_month()
            end_time = fake.date_time_between_dates(datetime_start=start_time)
            duration = (end_time - start_time).total_seconds()
            total_counts = fake.pyint()

            entries.append(dict(
                run=run,
                title=title,
                proton_charge=proton_charge,
                start_time=start_time.isoformat(),
                end_time=end_time.isoformat(),
                duration=duration,
                total_counts=total_counts,
            ))

        yield tornado.gen.sleep(1)

        self.write(dict(
            status="success",
            message=None,
            data=dict(
                entries=entries,
                pages=CATALOG_NUM_PAGES,
            ),
        ))

class CatalogBaseHandler(tornado.web.RequestHandler):
    def get_format_string(self):
        raise NotImplementedError("CatalogBaseHandler.get_format_string")

    @tornado.gen.coroutine
    def get(self, facility=None, instrument=None, experiment=None, run=None):
        with database() as db:
            cur = db.execute(('SELECT '
                              '  data '
                              'FROM catalog '
                              'WHERE facility IS ? '
                              'AND instrument IS ? '
                              'AND experiment IS ? '
                              'AND run IS ? '),
                             (facility, instrument, experiment, run))

            row = cur.fetchone()
            if row is not None:
                self.write(row[0])
                return

        http = tornado.httpclient.AsyncHTTPClient()
        fmt = self.get_format_string()
        prefix = 'http://icat.sns.gov:2080/icat-rest-ws/'

        response = yield http.fetch(
            prefix + fmt.format(
                facility=facility,
                instrument=instrument,
                experiment=experiment,
                run=run,
            ),
            headers={
                "Accept": "application/json",
            },
        )

        data = response.body
        with database() as db:
            db.execute(('insert into catalog ( '
                        '  facility, instrument, experiment, run, data '
                        ') values (?, ?, ?, ?, ?)'),
                       [facility, instrument, experiment, run, data])
            db.commit()

        self.write(response.body)

class CatalogFacilityHandler(CatalogBaseHandler):
    def get_format_string(self):
        return "experiment/{facility}"

class CatalogInstrumentHandler(CatalogBaseHandler):
    def get_format_string(self):
        return "experiment/{facility}/{instrument}/meta"

class CatalogExperimentHandler(CatalogBaseHandler):
    def get_format_string(self):
        return "experiment/{facility}/{instrument}/{experiment}/all"

class CatalogRunHandler(CatalogBaseHandler):
    def get_format_string(self):
        return "dataset/{facility}/{instrument}/{run}/lite"

def make_app():
    return tornado.web.Application([
        (r'/', IndexHandler),
        (r'/dist/(.*)', tornado.web.StaticFileHandler, dict(path="dist")),
        (r'/catalog/([0-9]+)', CatalogPageHandler),
        (r'/catalog/(SNS)', CatalogFacilityHandler),
        (r'/catalog/(SNS)/([A-Z]+)', CatalogInstrumentHandler),
        (r'/catalog/(SNS)/([A-Z]+)/(IPTS-[0-9]+)', CatalogExperimentHandler),
        (r'/catalog/(SNS)/([A-Z]+)/(IPTS-[0-9]+)/([0-9]+)', CatalogRunHandler),
    ])

if __name__ == "__main__":
    def parse_webpack_assets(filename):
        got_it = True
        while True:
            try:
                with open(filename, 'r') as f:
                    if not got_it:
                        print("Successfully loaded file")

                    return json.load(f)
            except FileNotFoundError:
                got_it = False
                print("Waiting for file '{}'".format(filename))
                time.sleep(0.5)

    print("[{}] Reloading...".format(datetime.datetime.now()))

    tornado.options.define("port", default=8888)
    tornado.options.define("assets", type=parse_webpack_assets)
    tornado.options.define("status")

    tornado.options.parse_command_line()

    tornado.platform.asyncio.AsyncIOMainLoop().install()

    app = make_app()
    app.listen(tornado.options.options["port"])

    asyncio.get_event_loop().run_forever()
