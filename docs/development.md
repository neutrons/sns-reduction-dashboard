# Development

## Makefile

`make run` target launches in parallel this 3 targets:

```
make api/run
make frontend/run
make nginx/run
```


## Run Django without uWSGI

For debugging, instead of `make api/run`, we can run Django without uWSGI!

```
cd api/
source venv/bin/activate

set -o allexport
source .env

PYTHONPATH=$(pwd) python src/manage.py runserver $PORT

```



## Dump database for fixtures

```
cd api/
source venv/bin/activate

set -o allexport
source .env

PYTHONPATH=$(pwd) python src/manage.py dumpdata <app_label[.ModelName]>

set +o allexport

```

Save this data in a json file in the fixtures folder.

## Load fixtures

Data to load must be in fixtures folder

```

./manage.py loaddata filename

```