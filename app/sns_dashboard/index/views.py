from django.shortcuts import render
from django.views import generic
from django.conf import settings
from django.contrib.auth.mixins import LoginRequiredMixin

class IndexView(LoginRequiredMixin,
                generic.TemplateView):
    template_name = 'index/index.html'
