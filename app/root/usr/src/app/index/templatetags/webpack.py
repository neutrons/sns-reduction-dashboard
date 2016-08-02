from django import template
from django.conf import settings

register = template.Library()

@register.simple_tag
def webpack(filename):
    return settings.WEBPACK_URL + filename
