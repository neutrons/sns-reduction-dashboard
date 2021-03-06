from rest_framework.decorators import api_view
from rest_framework.response import Response
from rest_framework.reverse import reverse


@api_view(['GET'])
def api_root(request, format=None):
    return Response({
        'catalog': reverse('catalog:api-root', request=request, format=format),
        'users': reverse('users:api-root', request=request, format=format),
        'reduction': reverse('reduction:api-root', request=request,
                             format=format),
    })
