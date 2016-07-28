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

# TL;DR

Run this to kill any existing version of the app, build a new one, start up the
services, and then watch the logs:

```console
$ # Copy .env.base to .env
$ make noop
$ # Create some passwords that you can use
$ ./scripts/create_pass.sh 128
$ # Edit the rest of the environment
$ vi .env
$ # Kill existing + build + start + watch the logs of the services
$ make down build up logs
```

# Installing

Run:

```bash
$ make build
```

# Running

Start the server(s) with:

```bash
$ make up
```

# Watching logs

Run:

```bash
$ make logs
```

# Killing the application

Run:

```bash
$ make down
```
