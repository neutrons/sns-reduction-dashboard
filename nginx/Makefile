################
# Utilities

################
# Environment variables

################
# Local variables


nginx_command := nginx
ifeq ($(NGINX_REQUIRES_SUDO),true)
nginx_command := sudo $(nginx_command)
endif

################
# Exported variables

################
# Standard targets

.PHONY: nginx/run
nginx/run: ## Run the nginx server
nginx/run: nginx/.env nginx/nginx.conf | nginx/logs
	$(load-env) && \
	$(nginx_command) -c $(notdir $(word 2,$^)) -g 'daemon off;' -p nginx

.PHONY: nginx/depend
nginx/depend:  ## Install nginx dependencies if needed

.PHONY: nginx/check
nginx/check:  ## Check nginx styles

.PHONY: nginx/clean
nginx/clean:  ## Clean up nginx temporary files

################
# Application specific targets

################
# Source transformations

nginx/logs:
	mkdir -p $@

nginx/nginx.conf: nginx/.env nginx/nginx.conf.template
	$(load-env) && \
	./scripts/env.bash subst $< < $(word 2,$^) > $@

nginx/.env: nginx/.env.template .env
	$(make-env)
