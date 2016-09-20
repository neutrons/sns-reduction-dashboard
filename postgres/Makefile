################
# Utilities

################
# Environment variables

################
# Exported variables

################
# Local variables

postgres_tag_name := sns_catalog_dashboard_postgres
postgres_tag_version := 1.0
postgres_tag := $(postgres_tag_name):$(postgres_tag_version)

postgres_volume_name := sns_catalog_dashboard_postgres_volume

################
# Standard targets

.PHONY: postgres/run
postgres/run: postgres/.env postgres/.depend.secondary postgres/.volume.secondary
	docker run \
		--rm \
		--env-file $< \
		--publish $(POSTGRES_HOST):$(POSTGRES_PORT):5432 \
		--volume $(postgres_volume_name):/var/lib/postgresql \
		$(postgres_tag)

.PHONY: postgres/depend
postgres/depend: postgres/.depend.secondary

.PHONY: postgres/check
postgres/check:

.PHONY: postgres/clean
postgres/clean:

################
# Application specific targets

################
# Source transformations

.SECONDARY: postgres/.depend.secondary
postgres/.depend.secondary: postgres/Dockerfile postgres/.env
	docker build \
		--tag $(postgres_tag) \
		postgres
	touch $@

.SECONDARY: postgres/.volume.secondary
postgres/.volume.secondary:
	docker volume create \
		--name $(postgres_volume_name)
	touch $@

postgres/.env: postgres/.env.template .env
	$(make-env)
