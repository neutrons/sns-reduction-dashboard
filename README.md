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

Run:

```bash
$ make build
```

# Running

Start the server(s) with:

```bash
$ make up
```
