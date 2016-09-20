################
# Utilities

################
# Environment variables

################
# Exported variables

################
# Standard targets

.PHONY: nginx/run
nginx/run: nginx/.env nginx/nginx.conf | nginx/logs
	$(load-env) && \
	nginx -c $(notdir $(word 2,$^)) -g 'daemon off;' -p nginx

.PHONY: nginx/depend
nginx/depend:

.PHONY: nginx/check
nginx/check:

.PHONY: nginx/clean
nginx/clean:

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
