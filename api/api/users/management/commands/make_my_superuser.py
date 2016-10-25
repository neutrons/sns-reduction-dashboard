from django.core.management.base import BaseCommand
from django.contrib.auth.models import User
import os


class Command(BaseCommand):
    help = '''Creates a superuser account if it doesn't already exist'''

    def handle(self, *args, **options):
        try:
            print('Trying to get admin user...')
            User.objects.get(username=os.environ['ADMIN_USER'])
            print('Admin user found!')

        except User.DoesNotExist:
            print('Creating admin user...')
            User.objects.create_superuser(
                os.environ['ADMIN_USER'],
                os.environ['ADMIN_EMAIL'],
                os.environ['ADMIN_PASS'],
            )
            print('Admin user created!')
