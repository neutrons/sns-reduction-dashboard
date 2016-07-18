from rest_framework import serializers
from . import models

class FacilitySerializer(serializers.ModelSerializer):
    class Meta:
        model = models.Facility
        fields = ('id', 'name')
