from rest_framework import routers
from . import views

router = routers.DefaultRouter(schema_title='Catalog API')
router.register(r'facility', views.FacilityViewSet)
router.register(r'instrument', views.InstrumentViewSet)

urlpatterns = router.urls
