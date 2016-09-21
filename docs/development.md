# Development

## Makefile

3 main targets:

```
make api/run
make frontend/run
make nginx/run
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

## Load Default models

Data to load must be
```

./manage.py loaddata filename

```