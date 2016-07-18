from django.conf.urls import url, include
from rest_framework import routers
from . import views

router = routers.DefaultRouter(schema_title='Configuration API')
router.register(r'facilities', views.FacilityViewSet)
router.register(r'instruments', views.InstrumentViewSet)

urlpatterns = [
    url(r'^', include(router.urls)),
]
