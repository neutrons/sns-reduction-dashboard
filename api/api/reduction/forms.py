from django import forms
from django.utils.translation import ugettext_lazy as _
from api.catalog.models import Instrument


class ConfigurationParametersForm(forms.Form):
    title = forms.CharField(
        required=True,
        label=_('Configuration Title'),
        initial='',
        help_text=_('The title of your configuration (viewable by others)'),
    )

    description = forms.CharField(
        widget=forms.Textarea,
        max_length=1024,
        required=True,
        label=_('Description'),
        initial='',
        help_text=_('The description of your configuration '
                    '(viewable by others)'),
    )

    instrument = forms.ModelChoiceField(
        queryset=Instrument.objects.all(),
        required=True,
        label=_('Instrument'),
        help_text=_('The instrument this configuration is made for'),
    )

    parameters__absolute_scale_factor = forms.FloatField(
        required=True,
        label=_('Absolute Scale Factor'),
        initial=1.0,
        help_text=_('The factor used when scaling the readings from the sensor.'),
    )

    parameters__sample_thickness = forms.FloatField(
        required=True,
        label=_('Sample Thickness'),
        initial=0.1,
        help_text=_('The thickness of the sample in mm'),
    )
