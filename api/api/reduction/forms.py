from django import forms
from django.utils.translation import ugettext_lazy as _
from .models import Configuration


class ConfigurationParametersForm(forms.Form):
    absolute_scale_factor = forms.FloatField(
        required=True,
        label=_('Absolute Scale Factor'),
        initial=1.0,
        help_text=_('The factor used when scaling the readings from the sensor.'),
    )

    sample_thickness = forms.FloatField(
        required=True,
        label=_('Sample Thickness'),
        initial=0.1,
        help_text=_('The thickness of the sample in mm'),
    )
