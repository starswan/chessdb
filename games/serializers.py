from rest_framework import serializers

from .models import Game, Player


class GameSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = Game
        fields = ['white_elo', 'black_elo', 'result']

class PlayerSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = Player
        fields = ['fideid', 'first_name', 'last_name']