from .models import Configuration
from .forms import ConfigurationParametersForm
from .serializers import ConfigurationSerializer
from rest_framework import viewsets
from django_vueformgenerator.schema import Schema
from rest_framework.response import Response
from rest_framework.decorators import list_route
from rest_framework.permissions import IsAuthenticatedOrReadOnly

class ConfigurationViewSet(viewsets.ModelViewSet):
    queryset = Configuration.objects.all()
    serializer_class = ConfigurationSerializer
    permission_classes = (IsAuthenticatedOrReadOnly,)

    @list_route()
    def schema(self, request):
        return Response(Schema().render(ConfigurationParametersForm()))
