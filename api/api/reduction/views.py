from .models import Configuration
from .forms import ConfigurationParametersForm
from .serializers import ConfigurationSerializer
from rest_framework import viewsets
from django_vueformgenerator.schema import Schema
from rest_framework.response import Response
from rest_framework.decorators import list_route


class ConfigurationViewSet(viewsets.ReadOnlyModelViewSet):
    queryset = Configuration.objects.all()
    serializer_class = ConfigurationSerializer

    @list_route()
    def schema(self, request):
        return Response(Schema().render(ConfigurationParametersForm()))
