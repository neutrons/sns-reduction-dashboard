from django.conf import settings
from django.contrib.auth import get_user_model
from django.contrib.postgres import fields as pgfields
from django.db import models


def get_sentinel_user():
    return get_user_model().objects.get_or_create(username='deleted')[0]


class Configuration(models.Model):
    title = models.CharField(
        'configuration title',
        help_text='The title of the configuration',
        max_length=128,
    )

    description = models.TextField(
        'configuration description',
        help_text='The description/title of the configuration',
        max_length=1024,
    )

    created_date = models.DateTimeField(
        'configuration creation date',
        help_text='The date this configuration was created',
        auto_now_add=True,
    )

    modified_date = models.DateTimeField(
        'configuration modification date',
        help_text='The date this configuration was last modified',
        auto_now=True,
    )

    parameters = pgfields.JSONField(
        'configuration parameters',
        help_text='The parameters for the configuration',
        default=dict,
    )

    instrument = models.ForeignKey(
        'catalog.Instrument',
        verbose_name='configuration\'s instrument',
        help_text='The instrument this configuration is for',
        on_delete=models.CASCADE,
        related_name='configurations',
    )

    owner = models.ForeignKey(
        settings.AUTH_USER_MODEL,
        verbose_name='configuration\'s owner',
        help_text='The user who created this configuration',
        on_delete=models.SET(get_sentinel_user),
        related_name='configurations',
    )
