from rest_framework import serializers
from . import models

class FacilitySerializer(serializers.HyperlinkedModelSerializer):
    instruments = serializers.HyperlinkedIdentityField(
        many=True,
        view_name='instrument-detail',
    )

    class Meta:
        model = models.Facility
        fields = ('url', 'pk', 'name', 'instruments')

class InstrumentSerializer(serializers.HyperlinkedModelSerializer):
    facility = serializers.HyperlinkedIdentityField(
        view_name='facility-detail',
    )

    class Meta:
        model = models.Instrument
        fields = ('url', 'pk', 'name', 'facility')
