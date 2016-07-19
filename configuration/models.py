from django.db import models

# Create your models here.

class Facility(models.Model):
    name = models.CharField(max_length=32)
    desc = models.CharField(max_length=1024)

    def __str__(self):
        return "Facility(name={self.name})".format(self=self)

class Instrument(models.Model):
    name = models.CharField(max_length=32)
    desc = models.CharField(max_length=1024)
    facility = models.ForeignKey(Facility, on_delete=models.CASCADE,
                                 related_name='instruments')

    def __str__(self):
        return "Instrument(name={self.name}, facility={self.facility})".format(
            self=self,
        )

class Configuration(models.Model):
    name = models.CharField(max_length=32)
    desc = models.CharField(max_length=1024)
    instrument = models.ForeignKey(Instrument, on_delete=models.CASCADE,
                                   related_name='configurations')

    def __str__(self):
        return "Configuration(name={self.name}, instrument={self.instrument})".format(
            self=self,
        )

class Entry(models.Model):
    name = models.CharField(max_length=32)
    key = models.CharField(max_length=32)
    value = models.CharField(max_length=32)
    advanced = models.BooleanField()
    configuration = models.ForeignKey(Configuration, on_delete=models.CASCADE,
                                      related_name='entries')

    def __str__(self):
        return "Entry(name={self.name}, key={self.key}, value={self.value}, advanced={self.advanced}, configuration={self.configuration})".format(
            self=self,
        )
