# Create your tests here.

from django.urls import reverse
from rest_framework import status
from rest_framework.test import APITestCase

from games.models import Player


class PlayerTests(APITestCase):
    def test_create_player(self):
        """
        Ensure we can create a player object.
        """
        url = reverse('players')
        # url = '/players'
        data = {'first_name': 'Fred', 'last_name': 'Bloggs', 'fideid': 127876}
        response = self.client.post(url, data, format='json')
        self.assertEqual(response.status_code, status.HTTP_201_CREATED)
        self.assertEqual(Player.objects.count(), 1)
        self.assertEqual(Player.objects.get().first_name, 'Fred')