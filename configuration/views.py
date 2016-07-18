from . import models
from . import serializers
from rest_framework import generics

class FacilityList(generics.ListCreateAPIView):
    queryset = models.Facility.objects.all()
    serializer_class = serializers.FacilitySerializer

class FacilityDetail(generics.RetrieveUpdateDestroyAPIView):
    queryset = models.Facility.objects.all()
    serializer_class = serializers.FacilitySerializer
