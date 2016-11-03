from rest_framework import serializers
from .models import Configuration


class ConfigurationSerializer(serializers.ModelSerializer):
    owner = serializers.HiddenField(
        default=serializers.CurrentUserDefault(),
    )

    class Meta:
        model = Configuration
        fields = ('title', 'description', 'instrument', 'parameters', 'owner')
