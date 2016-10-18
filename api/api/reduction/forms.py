from django import forms
from .models import Configuration


class ConfigurationCreateForm(forms.ModelForm):
    class Meta:
        model = Configuration
        fields = ('description', 'instrument')


class ConfigurationParametersForm(forms.Form):
    absolute_scale_factor = forms.FloatField()
    sample_thickness = forms.FloatField()
