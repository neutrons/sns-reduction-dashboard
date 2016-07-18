from . import models
from . import serializers
from rest_framework import viewsets

class FacilityViewSet(viewsets.ModelViewSet):
    queryset = models.Facility.objects.all()
    serializer_class = serializers.FacilitySerializer

class InstrumentViewSet(viewsets.ModelViewSet):
    queryset = models.Instrument.objects.all()
    serializer_class = serializers.InstrumentSerializer

class ConfigurationViewSet(viewsets.ModelViewSet):
    queryset = models.Configuration.objects.all()
    serializer_class = serializers.ConfigurationSerializer

class EntryViewSet(viewsets.ModelViewSet):
    queryset = models.Entry.objects.all()
    serializer_class = serializers.EntrySerializer
