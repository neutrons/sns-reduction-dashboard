from django import forms
from .models import Configuration


class ConfigurationParametersForm(forms.Form):
    absolute_scale_factor = forms.FloatField()
    sample_thickness = forms.FloatField()
