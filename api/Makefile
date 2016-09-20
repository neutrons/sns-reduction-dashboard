################
# Utilities

################
# Environment variables

################
# Exported variables

################
# Standard targets

.PHONY: api/run
api/run: api/.env api/.depend.secondary api/.migrate.secondary
	$(load-env) && \
	source api/venv/bin/activate && \
	api/venv/bin/uwsgi --ini api/uwsgi.ini

.PHONY: api/depend
api/depend: api/.depend.secondary

.PHONY: api/check
api/check:

.PHONY: api/clean
api/clean:

################
# Application specific targets

.PHONY: api/migrate
api/migrate: api/.migrate.secondary

################
# Source transformations

api/venv:
	python3 -m virtualenv $@

.SECONDARY: api/.depend.secondary
api/.depend.secondary: api/requirements.txt | api/venv
	source api/venv/bin/activate && \
	python3 -m pip install -r $< && \
	touch $@

.SECONDARY: api/.migrate.secondary
api/.migrate.secondary: api/.env api/.depend.secondary \
                        $(wildcard api/src/*/models.py) api/src/settings.py
	$(load-env) && \
	source api/venv/bin/activate && \
	python3 api/src/manage.py makemigrations && \
	python3 api/src/manage.py migrate && \
	touch $@

api/.env: api/.env.template .env
	$(make-env)
