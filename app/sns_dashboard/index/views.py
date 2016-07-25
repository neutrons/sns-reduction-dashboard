from django.shortcuts import render
from django.views import generic
from django.conf import settings

class IndexView(generic.TemplateView):
    template_name = 'index/index.html'
