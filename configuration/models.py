from django.db import models

# Create your models here.

class Facility(models.Model):
    name = models.CharField(max_length=32)

class Instrument(models.Model):
    name = models.CharField(max_length=32)
    facility = models.ForeignKey(Facility, on_delete=models.CASCADE)

class Configuration(models.Model):
    name = models.CharField(max_length=32)
    instrument = models.ForeignKey(Instrument, on_delete=models.CASCADE)

class Entry(models.Model):
    name = models.CharField(max_length=32)
    key = models.CharField(max_length=32)
    value = models.CharField(max_length=32)
    advanced = models.BooleanField()
