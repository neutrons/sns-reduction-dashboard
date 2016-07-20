from django.shortcuts import render
from django.views import generic
from django.conf import settings

import json
import time

# Create your views here.

def json_load_file_until_success(filename):
    while True:
        try:
            with open(filename, 'r') as f:
                return json.load(f)
        except FileNotFoundError:
            time.sleep(0.5)

class IndexView(generic.TemplateView):
    template_name = 'index/index.html'

    def get_context_data(self, **kwargs):
        context = super(IndexView, self).get_context_data(**kwargs)
        context['assets'] = json_load_file_until_success(settings.ASSETS_FILE)
        return context
