from rest_framework import serializers
from . import models


class InstrumentSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = models.Instrument
        exclude = ['icat_name', 'ldap_name', 'drive_path']
        extra_kwargs = {
            'url': {
                'view_name': 'catalog:instrument-detail',
            },
            'facility': {
                'view_name': 'catalog:facility-detail',
            },
        }


class FacilitySerializer(serializers.HyperlinkedModelSerializer):
    url = serializers.HyperlinkedIdentityField(
        view_name='catalog:facility-detail',
    )

    instruments = serializers.HyperlinkedRelatedField(
        many=True,
        view_name='catalog:instrument-detail',
        read_only=True,
    )

    class Meta:
        model = models.Facility
        fields = '__all__'


class NestedInstrumentSerializer(InstrumentSerializer):
    facility = FacilitySerializer(
        read_only=True,
    )

    class Meta(InstrumentSerializer.Meta):
        pass


class NestedFacilitySerializer(FacilitySerializer):
    instruments = InstrumentSerializer(many=True, read_only=True)

    class Meta(FacilitySerializer.Meta):
        pass
