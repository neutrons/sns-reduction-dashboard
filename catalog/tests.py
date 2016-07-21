from django.test import TestCase
from django.core.urlresolvers import reverse
from django.contrib.auth.models import AnonymousUser, User
from rest_framework import status
from rest_framework.test import APITestCase
from .models import Facility, Instrument

def p(obj):
    import json
    print(json.dumps(obj, indent=2))

# Create your tests here.
class FacilityAPITestCase(APITestCase):
    def setUp(self):
        self.sns = Facility.objects.create(
            name='SNS',
            description='Spallation Neutron Source',
        )
        self.eqsans = Instrument.objects.create(
            name='EQSANS',
            description='EQSANS Description',
            beamline='BL-6',
            type='SANS',
            icat_name='EQSANS',
            ldap_name='eqsans',
            drive_name='EQSANS',
            facility=self.sns,
        )

        self.superuser = User.objects.create_superuser(
            username='admin',
            email='admin@foo.com',
            password='admin_secret',
        )
        self.user = User.objects.create_user(
            username='john',
            email='john@foo.com',
            password='john_secret',
        )

    def test_facility_list(self):
        '''Ensure that listing the facility shows non-expanded instruments'''
        url = reverse('facility-list')
        response = self.client.get(url, format='json')
        expected = {
            "results": [
                {
                    "url": "http://testserver/catalog/facilities/SNS/",
                    "instruments": [
                        "http://testserver/catalog/instruments/EQSANS/",
                    ],
                    "description": "Spallation Neutron Source",
                }
            ],
            "next": None,
            "count": 1,
            "previous": None,
        }

        self.assertEqual(response.status_code, status.HTTP_200_OK)
        self.assertEqual(response.data, expected)

    def test_facility_detail(self):
        '''Ensure that facility detail includes expanded instruments'''
        url = reverse('facility-detail', args=[self.sns.name])
        response = self.client.get(url, format='json')
        expected = {
            "url": "http://testserver/catalog/facilities/SNS/",
            "instruments": [
                {
                    "url": "http://testserver/catalog/instruments/EQSANS/",
                    "description": "EQSANS Description",
                    "beamline": "BL-6",
                    "type": "SANS",
                    "reduction_available": False,
                    "facility": "http://testserver/catalog/facilities/SNS/"
                }
            ],
            "description": "Spallation Neutron Source"
        }

        self.assertEqual(response.status_code, status.HTTP_200_OK)
        self.assertEqual(response.data, expected)

    def test_instrument_list(self):
        '''Ensure that instrument list has correct data'''
        url = reverse('instrument-list')
        response = self.client.get(url, format='json')
        expected = {
            "count": 1,
            "next": None,
            "previous": None,
            "results": [
                {
                    "url": "http://testserver/catalog/instruments/EQSANS/",
                    "description": "EQSANS Description",
                    "beamline": "BL-6",
                    "type": "SANS",
                    "reduction_available": False,
                    "facility": "http://testserver/catalog/facilities/SNS/"
                }
            ]
        }

        self.assertEqual(response.status_code, status.HTTP_200_OK)
        self.assertEqual(response.data, expected)

    def test_instrument_detail(self):
        '''Ensure that instrument detail has correct data'''
        url = reverse('instrument-detail', args=[self.eqsans.name])
        response = self.client.get(url, format='json')
        expected = {
            "url": "http://testserver/catalog/instruments/EQSANS/",
            "description": "EQSANS Description",
            "beamline": "BL-6",
            "type": "SANS",
            "reduction_available": False,
            "facility": "http://testserver/catalog/facilities/SNS/"
        }

        self.assertEqual(response.status_code, status.HTTP_200_OK)
        self.assertEqual(response.data, expected)
