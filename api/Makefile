################
# Utilities

################
# Environment variables

################
# Exported variables

################
# Standard targets

.PHONY: api/run
api/run: api/.env api/.depend.secondary
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

################
# Source transformations

api/venv:
	python3 -m virtualenv $@

.SECONDARY: api/.depend.secondary
api/.depend.secondary: api/requirements.txt | api/venv
	source api/venv/bin/activate && \
	python3 -m pip install -r $< && \
	touch $@

api/.env: api/.env.template .env
	$(make-env)
