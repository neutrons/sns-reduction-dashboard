#!/usr/bin/env python

import tornado.options
import tornado.escape
import tornado.ioloop
import tornado.queues
import tornado.web

import faker

import glob
import json
import re
import datetime

CATALOG_NUM_PAGES = 10

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


def make_app():
    return tornado.web.Application([
        (r'/', IndexHandler),
        (r'/dist/(.*)', tornado.web.StaticFileHandler, dict(path="dist")),
        (r'/catalog/([0-9]+)', CatalogPageHandler),
    ])

if __name__ == "__main__":
    def parse_webpack_assets(filename):
        with open(filename, 'r') as f:
            return json.load(f)

    print("[{}] Reloading...".format(datetime.datetime.now()))

    tornado.options.define("port", default=8888)
    tornado.options.define("assets", type=parse_webpack_assets)
    tornado.options.define("status")

    tornado.options.parse_command_line()

    app = make_app()
    app.listen(tornado.options.options["port"])
    tornado.ioloop.IOLoop.instance().start()
