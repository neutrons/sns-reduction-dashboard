from rest_framework import routers
from .views import ConfigurationViewSet

router = routers.DefaultRouter(schema_title='Reduction API')
router.register(r'configuration', ConfigurationViewSet)

urlpatterns = router.urls
