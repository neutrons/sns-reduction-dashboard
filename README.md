# dashboard-config-demo

> Demo of how we could set up the database and models for editing configurations
> genericly on the front end, using a combination of Django,
> DjangoRestFramework, VueJS, and Webpack.

# Deployment Environment

All of the commands require a development environment to be set. The easiest way
to do this is to just export the variable before running everything. So this is:

```bash
$ export ENV=local # or dev, stage, or prod
```

Alternatively, you can set it per `make` command, like so:

```bash
$ make ENV=local <target>
```

# Installing

Make a virtual environment:

```bash
$ python3 -m virtualenv venv
$ source venv/bin/activate
```

Install NPM and Python dependencies:

```bash
$ make depend
```

Apply migrations to database

```bash
$ make migrate
```

# Running

Start both the JavaScript webpack-dev-server and Django servers:

```bash
$ make
```
