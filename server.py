#!/usr/bin/env python

import tornado.options
import tornado.escape
import tornado.ioloop
import tornado.queues
import tornado.web

import glob
import json
import re
import datetime

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

def make_app():
    return tornado.web.Application([
        (r'/', IndexHandler),
        (r'/dist/(.*)', tornado.web.StaticFileHandler, dict(path="dist")),
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
