################
# Utilities

################
# Environment variables

################
# Exported variables

################
# Standard targets

.PHONY: frontend/run
frontend/run: ## Run the frontend server
frontend/run: frontend/.env frontend/.depend.secondary | frontend/dist
ifeq ($(USE_WEBPACK_DEV_SERVER),true)
	$(load-env) && \
	(cd frontend && \
	./node_modules/.bin/webpack-dev-server \
		--host $(FRONTEND_HOST) \
		--port $(FRONTEND_PORT) \
	)
else
	$(load-env) && \
	node frontend/node_modules/.bin/webpack --watch
endif

.PHONY: frontend/depend
frontend/depend: ## Install frontend dependencies if needed
frontend/depend: frontend/.depend.secondary

.PHONY: frontend/check
frontend/check:  ## Check frontend styles

.PHONY: frontend/clean
frontend/clean:  ## Clean up frontend temporary files

################
# Application specific targets

################
# Source transformations

frontend/dist:
	mkdir -p $@

.SECONDARY: frontend/.depend.secondary
frontend/.depend.secondary: frontend/package.json
	(cd frontend && npm install) && \
	touch $@

frontend/.env: frontend/.env.template .env
	$(make-env)
