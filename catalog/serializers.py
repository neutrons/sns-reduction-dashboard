from rest_framework import serializers
from . import models

class InstrumentSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = models.Instrument
        exclude = ['icat_name', 'ldap_name', 'drive_name']

class FacilitySerializer(serializers.HyperlinkedModelSerializer):
    instruments = serializers.HyperlinkedRelatedField(
        many=True,
        view_name='instrument-detail',
        read_only=True,
    )

    class Meta:
        model = models.Facility
        fields = '__all__'

class NestedFacilitySerializer(FacilitySerializer):
    instruments = InstrumentSerializer(many=True, read_only=True)

    class Meta(FacilitySerializer.Meta):
        pass
