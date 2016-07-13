# SNS Catalog Dashboard

A demo of the design of a dashboard for managing reductions, configurations, and
jobs from SNS.

# Installing

We need to install the JavaScript and Python dependencies, so use the command:

```bash
$ make depend
```

Note: Make sure that you have a virtual environment set up and activated! The
script will check.

# Running

To run, we need to start both the Python Tornado server and the Webpack dev
server. We need the latter to do hot reloading in the browser. To start them,
run:

```bash
$ make
```

You can kill both with Ctrl-C.

To run without watching `server.py` and `server.js` for changes, instead run:

```bash
$ make no-watch
```
