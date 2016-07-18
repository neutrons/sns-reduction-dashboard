from rest_framework import serializers
from . import models

class EntrySerializer(serializers.HyperlinkedModelSerializer):
    configuration = serializers.HyperlinkedRelatedField(
        view_name='configuration-detail',
        queryset=models.Configuration.objects.all(),
    )

    class Meta:
        model = models.Entry
        fields = ('url', 'pk', 'name', 'key', 'value', 'advanced', 'configuration')
        depth = 1

class ConfigurationSerializer(serializers.HyperlinkedModelSerializer):
    instrument = serializers.HyperlinkedRelatedField(
        view_name='instrument-detail',
        queryset=models.Instrument.objects.all(),
    )
    entries = serializers.HyperlinkedIdentityField(
        many=True,
        view_name='entry-detail',
        read_only=True,
    )

    class Meta:
        model = models.Configuration
        fields = ('url', 'pk', 'name', 'instrument', 'entries')
        depth = 1

    def create(self, validated_data):
        lookup = {
            ('HFIR', 'BioSANS'): [
                {
                    'name': 'FooName',
                    'key': 'foo',
                    'value': '32',
                    'advanced': False,
                },
                {
                    'name': 'BarName',
                    'key': 'bar',
                    'value': 'baz',
                    'advanced': True,
                }
            ],
            ('SNS', 'EQSANS'): [
                {
                    'name': 'BingName',
                    'key': 'bing',
                    'value': 'true',
                    'advanced': False,
                },
            ],
        }

        instrument = validated_data['instrument']
        facility = instrument.facility
        configuration = models.Configuration.objects.create(**validated_data)

        entries = []
        for data in lookup[(facility.name, instrument.name)]:
            entry = models.Entry.objects.create(configuration=configuration, **data)

        return configuration

class InstrumentSerializer(serializers.HyperlinkedModelSerializer):
    facility = serializers.HyperlinkedRelatedField(
        view_name='facility-detail',
        read_only=False,
        queryset=models.Facility.objects.all(),
    )
    configurations = serializers.HyperlinkedIdentityField(
        many=True,
        view_name='configuration-detail',
        read_only=True,
    )

    class Meta:
        model = models.Instrument
        fields = ('url', 'pk', 'name', 'facility', 'configurations')
        depth = 1


class FacilitySerializer(serializers.HyperlinkedModelSerializer):
    instruments = serializers.HyperlinkedIdentityField(
        many=True,
        view_name='instrument-detail',
        read_only=True,
    )

    class Meta:
        model = models.Facility
        fields = ('url', 'pk', 'name', 'instruments')
        depth = 1
