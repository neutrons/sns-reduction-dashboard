from django.contrib import admin

# Register your models here.
from .models import User
#from django.contrib.auth.models import Group

admin.site.register(User)
#admin.site.register(Group)