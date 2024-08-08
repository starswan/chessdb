# Create your views here.

# from rest_framework import viewsets
#
from games.models import Game, Player
from games.serializers import GameSerializer, PlayerSerializer
#
#
# class GameViewSet(viewsets.ModelViewSet):
#     queryset = Game.objects.all()
#     serializer_class = GameSerializer
#
# class PlayerViewSet(viewsets.ModelViewSet):
#     queryset = Player.objects.all()
#     serializer_class = PlayerSerializer

#     from snippets.models import Snippet
# from snippets.serializers import SnippetSerializer
from rest_framework import generics


class PlayerList(generics.ListCreateAPIView):
    queryset = Player.objects.all()
    serializer_class = PlayerSerializer


class PlayerDetail(generics.RetrieveUpdateDestroyAPIView):
    queryset = Player.objects.all()
    serializer_class = PlayerSerializer