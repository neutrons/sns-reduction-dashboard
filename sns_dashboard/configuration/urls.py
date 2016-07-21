from django.conf.urls import url, include
from rest_framework import routers
from . import views

router = routers.DefaultRouter(schema_title='Configuration API')
router.register(r'facilities', views.FacilityViewSet)
router.register(r'instruments', views.InstrumentViewSet)
router.register(r'configurations', views.ConfigurationViewSet)
router.register(r'entries', views.EntryViewSet)

urlpatterns = [
    url(r'^', include(router.urls)),
]
