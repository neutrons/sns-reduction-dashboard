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
        fields = ('url', 'pk', 'name', 'desc', 'instrument', 'entries')
        depth = 1

    def create(self, validated_data):
        lookup = {}
        lookup['default'] = [
            {
                'name': 'General Parameter 1',
                'key': 'gp1',
                'value': '42',
                'advanced': False,
            },
            {
                'name': 'General Parameter 2',
                'key': 'gp2',
                'value': 'Bar',
                'advanced': False,
            },
            {
                'name': 'General Parameter 3',
                'key': 'gp3',
                'value': 'Wow',
                'advanced': True,
            },
        ]

        lookup[('SNS', 'EQSANS')] = lookup['default'] + [
            {
                'name': 'EQSANS Parameter',
                'key': 'foo',
                'value': '1.234',
                'advanced': True,
            },
        ]

        instrument = validated_data['instrument']
        facility = instrument.facility
        configuration = models.Configuration.objects.create(**validated_data)

        entries = []
        key = (facility.name, instrument.name)
        for data in lookup.get(key, lookup['default']):
            entry = models.Entry.objects.create(configuration=configuration, **data)

        return configuration

class NestedConfigurationSerializer(ConfigurationSerializer):
    entries = EntrySerializer(many=True)

    class Meta(ConfigurationSerializer.Meta):
        pass

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
        fields = ('url', 'pk', 'name', 'desc', 'facility', 'configurations')
        depth = 1

class NestedInstrumentSerializer(InstrumentSerializer):
    configurations = ConfigurationSerializer(many=True)

    class Meta(InstrumentSerializer.Meta):
        pass

class FacilitySerializer(serializers.HyperlinkedModelSerializer):
    instruments = serializers.HyperlinkedIdentityField(
        many=True,
        view_name='instrument-detail',
        read_only=True,
    )

    class Meta:
        model = models.Facility
        fields = ('url', 'pk', 'name', 'desc', 'instruments')
        depth = 1

class NestedFacilitySerializer(FacilitySerializer):
    instruments = InstrumentSerializer(many=True)

    class Meta(FacilitySerializer.Meta):
        pass
