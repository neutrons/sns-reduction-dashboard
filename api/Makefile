################
# Utilities

################
# Environment variables

################
# Exported variables

################
# Standard targets

.PHONY: api/run
api/run: ## Run the API server
api/run: api/.env api/.depend.secondary api/.migrate.secondary
	$(load-env) && \
	source api/venv/bin/activate && \
	api/venv/bin/uwsgi --ini api/uwsgi.ini

.PHONY: api/depend
api/depend: api/.depend.secondary  ## Install API dependencies if needed

.PHONY: api/check
api/check: api/.depend-dev.secondary ## Check API styles
	$(load-env) && \
	source api/venv/bin/activate && \
	flake8 --config=api/flake8.config api/api

.PHONY: api/clean
api/clean:  ## Clean up API temporary files

################
# Application specific targets

.PHONY: api/migrate
api/migrate: api/.migrate.secondary  ## Migrate API databases if needed

.PHONY: api/migrate-zero
api/migrate-zero: api/.env  ## Remove databases
	$(load-env) && \
	source api/venv/bin/activate && \
	python api/api/manage.py makemigrations && \
	python api/api/manage.py migrate catalog zero && \
	python api/api/manage.py migrate reduction zero && \
	python api/api/manage.py migrate users zero && \
	rm -f api/.migrate.secondary

################
# Source transformations

api/venv:
	python3 -m virtualenv $@

.SECONDARY: api/.depend.secondary
api/.depend.secondary: api/.env api/requirements.txt | api/venv
	$(load-env) && \
	source api/venv/bin/activate && \
	python -m pip install --upgrade -r $(word 2,$^) && \
	touch $@

.SECONDARY: api/.depend-dev.secondary
api/.depend-dev.secondary: api/.env api/dev-requirements.txt \
                           api/.depend.secondary | api/venv
	$(load-env) && \
	source api/venv/bin/activate && \
	python -m pip install --upgrade -r $(word 2,$^) && \
	touch $@

.SECONDARY: api/.migrate.secondary
api/.migrate.secondary: api/.env api/.depend.secondary \
                        $(wildcard api/api/*/models.py) api/api/settings.py \
                        $(wildcard api/api/fixtures/*.json)
	$(load-env) && \
	source api/venv/bin/activate && \
	python api/api/manage.py makemigrations --no-input && \
	python api/api/manage.py migrate --no-input && \
	python api/api/manage.py make_my_superuser && \
	python api/api/manage.py loaddata $(call containing,/fixtures/,$^) && \
	python api/api/manage.py collectstatic --no-input && \
	touch $@

api/.env: api/.env.template .env
	$(make-env)
