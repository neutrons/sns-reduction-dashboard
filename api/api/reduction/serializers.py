from rest_framework import serializers
from .models import Configuration


class ConfigurationSerializer(serializers.ModelSerializer):
    class Meta:
        model = Configuration
        fields = ('description', 'instrument', 'parameters')
