# SNS Reduction Dashboard

An implementation of a web-based reduction controller for neutron scientists at
the Spallation Neutron Source. The overall goal is to be able to manage jobs
that are sent to a computing cluster that can reduce experimental data to a
more manageable size.

It uses the tools: Django, DjangoRestFramework, Nginx, and VueJS.

# Usage

The short answer to how to use is:

```console
$ make .env    # Configuration
$ vi .env      # Configuration
$ make depend  # Installation
$ make run     # Running
```

The longer answer is in the following sections.

# Configuration

Create an environment file to configure the application.

To do this, create a `.env` file with:

```console
$ make .env
touch .env
cp .env .env.20161011145024
./scripts/env.bash merge .env.20161011145024 .env.base > .env
./scripts/env.bash to-makefile > .env.makefile
make: `.env' is up to date.
```

Then we need to modify the file with:

```console
$ vi .env
```

You might find the `./scripts/create_pass.sh` program useful:

```console
$ ./scripts/create_pass.sh 128
a16b48b76581452da81dcd3c5f50753a68362bc0679b8038606a962a19d9e6452d56ba30f030660e060645d3c2f0774a406f5ce24115cf3cc9f423757ac7de33
```

# Installation

We need to install dependencies.

This project uses a Makefile as a task runner, so installing dependencies is
just:

```console
$ make depend
...
lots of output
...
```

If an error occurs and you need to reinstall dependencies for one specific
service (e.g. `api`, `frontend`, or `nginx`), then you can run:

```console
$ make api/depend -B
```

The `-B` flag says "Run these commands unconditionally." Normally, if no files
specifying dependencies have changed (`requirements.txt` or `package.json`),
then Make knows not to try to reinstall them. But in case we need to get around
that feature, the `-B` will allow us to run them even if `requirements.txt` or
`package.json` haven't been changed.

# Running

Finally, we need to actually run the servers.

To do this, we need to run 3 programs at once, which Make will take care of for
us. We just need to run:

```console
$ make run  # or just: make
```

The URL of this will be determined from the environment file. To easily check
what the URL should be to view the page, we can run:

```console
$ make print-url
http://localhost:80
```

When we want to kill the server, we can simply Ctrl-C the Make process.
