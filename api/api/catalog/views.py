from . import models
from . import serializers
from rest_framework import viewsets
from rest_framework.response import Response


class NestedModelMixin(object):
    """
    Retrieve a model but as a nested representation instead of a flat one.
    """
    def retrieve(self, request, *args, **kwargs):
        instance = self.get_object()
        serializer = self.get_nested_serializer(instance)
        return Response(serializer.data)

    def get_nested_serializer(self, *args, **kwargs):
        """
        Return the nested serializer instance that should be used for
        validating and deserializing input, and for serializing output.
        """
        serializer_class = self.get_nested_serializer_class()
        kwargs['context'] = self.get_serializer_context()
        return serializer_class(*args, **kwargs)

    def get_nested_serializer_class(self):
        """
        Return the class to use for the nested serializer.
        Defaults to using `self.nested_serializer_class`.

        You may want to override this if you need to provide different
        serializations depending on the incoming request.

        (Eg. admins get full serialization, others get basic serialization)
        """
        assert self.nested_serializer_class is not None, (
            "'%s' should either include a `nested_serializer_class` "
            "attribute, or override the `get_nested_serializer_class()` "
            "method."
            % self.__class__.__name__
        )

        return self.nested_serializer_class


class FacilityViewSet(NestedModelMixin, viewsets.ReadOnlyModelViewSet):
    queryset = models.Facility.objects.all()
    serializer_class = serializers.FacilitySerializer
    nested_serializer_class = serializers.NestedFacilitySerializer


class InstrumentViewSet(NestedModelMixin, viewsets.ReadOnlyModelViewSet):
    queryset = models.Instrument.objects.all()
    serializer_class = serializers.InstrumentSerializer
    nested_serializer_class = serializers.NestedInstrumentSerializer
