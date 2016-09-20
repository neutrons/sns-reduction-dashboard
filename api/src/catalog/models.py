from django.db import models
from django.utils.translation import ugettext_lazy as _
# Create your models here.

class AutoRepr(object):
    def __repr__(self):
        fields = (
            "{}={!r}".format(field.name, getattr(self, field.name))
            for field in self._meta.get_fields()
        )

        return "{}({})".format(
            self.__class__.__name__,
            ', '.join(fields),
        )

    def __str__(self):
        primary_key = next(
            field
            for field in self._meta.get_fields()
            if hasattr(field, 'primary_key') and field.primary_key
        )

        return "{}({}={!r})".format(
            self.__class__.__name__,
            primary_key.name,
            getattr(self, primary_key.name),
        )

class Facility(AutoRepr, models.Model):
    name = models.CharField(
        'facility name',
        help_text='Facility name (e.g. "SNS" or "HFIR")',
        max_length=32,
        primary_key=True,
    )

    description = models.CharField(
        'facility description',
        help_text='Facility description (e.g. "Spallation Neutron Source")',
        max_length=1024,
    )

    active = models.BooleanField(
        'facility is active',
        help_text='Whether the facility is active and working in the dashboard',
        default=False,
    )

    class Meta:
        verbose_name_plural = _("Facilities")
        ordering = ('name',)

class Instrument(AutoRepr, models.Model):
    name = models.CharField(
        'instrument name',
        help_text='Instrument name (e.g. "EQSANS" or "BioSANS")',
        max_length=32,
        primary_key=True,
    )

    description = models.CharField(
        'instrument description',
        help_text='Instrument description (e.g. "Backscattering Spectrometer")',
        max_length=1024,
    )

    beamline = models.CharField(
        'instrument beamline',
        help_text='Beamline that goes into instrument (e.g. "BL-2")',
        max_length=32,
    )

    type = models.CharField(
        'instrument type',
        help_text='Instrument type (e.g. "SANS")',
        max_length=32,
    )

    icat_name = models.CharField(
        'instrument icat name',
        help_text='Name used for querying ICAT server (e.g. "EQSANS")',
        max_length=32,
    )

    ldap_name = models.CharField(
        'instrument ldap name',
        help_text='Name used for querying LDAP server',
        max_length=32,
    )

    drive_name = models.CharField(
        'instrument drive name',
        help_text='Name used for loading files from shared filesystem',
        max_length=32,
    )

    reduction_available = models.BooleanField(
        'instrument can do reductions',
        help_text='Whether the instrument can do reductions',
        default=False,
    )

    active = models.BooleanField(
        'instrument is active',
        help_text='Whether the instrument is active and working in the dashboard',
        default=False,
    )

    facility = models.ForeignKey(
        'Facility',
        verbose_name='instrument\'s facility',
        help_text='The facility the instrument is at (e.g. "SNS")',
        on_delete=models.CASCADE,
        related_name='instruments',
    )

    class Meta:
        ordering = ('beamline',)
