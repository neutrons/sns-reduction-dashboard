from . import serializers
from django.contrib.auth import get_user_model
from rest_framework import viewsets
from rest_framework.authtoken import serializers as authserializers
from rest_framework.authtoken.models import Token
from rest_framework.response import Response


class UserProfileViewSet(viewsets.ReadOnlyModelViewSet):
    queryset = get_user_model().objects.all()
    serializer_class = serializers.UserProfileSerializer


class UserLoginViewSet(viewsets.ViewSet):
    def create(self, request, format=None):
        serializer = authserializers.AuthTokenSerializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        user = serializer.validated_data['user']
        token, created = Token.objects.get_or_create(user=user)
        return Response({'token': token.key})


class UserAuthCheckViewSet(viewsets.ViewSet):
    def create(self, request, format=None):
        serializer = serializers.UserAuthTokenSerializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        user = serializer.validated_data['user']
        return Response({'username': getattr(user, 'username', None)})
