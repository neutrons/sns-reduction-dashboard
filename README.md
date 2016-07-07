# SNS Catalog Dashboard

A demo of the design of a dashboard for managing reductions, configurations, and
jobs from SNS.

# Running

First we need to generate the bootstrap that we'll use. To do this, go to
[Bootstrap 3's "Customize" page](http://getbootstrap.com/customize/). We then
need to upload the [`config.json` file](./config.json).

Once all of our settings are added, then we need to download the zip file at the
end of the page, which will give us a `bootstrap.zip` file that we can put in
the root of this directory.

Now we can run a command to extract everything from the zip file and start a
server:

```bash
$ make
```

This will start a server at [http://localhost:8888](http://localhost:8888)

# Cleaning up

Run

```bash
$ make clean
```
