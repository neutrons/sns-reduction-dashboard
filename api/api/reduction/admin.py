from django.contrib import admin
from . import models


@admin.register(models.BaseConfiguration)
class BaseConfigurationAdmin(admin.ModelAdmin):
    pass


@admin.register(models.Configuration)
class ConfigurationAdmin(admin.ModelAdmin):
    readonly_fields = ('parameters',)
