from django.conf.urls import url
from django.views.decorators.cache import cache_page
from . import views

urlpatterns = [
    url(r'^$', cache_page(5)(views.IndexView.as_view())),
]
