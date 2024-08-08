from django.db import models

class Opening(models.Model):
    ecocode = models.CharField(max_length=3)
    name = models.CharField(max_length=50)
    variation = models.CharField(max_length=50)

class Player(models.Model):
    fideid = models.IntegerField()
    first_name = models.CharField(max_length=30)
    last_name = models.CharField(max_length=30)
    white_games_count = models.IntegerField()
    black_games_count = models.IntegerField()

class Game(models.Model):
    white = models.ForeignKey(Player, on_delete=models.CASCADE)
    black = models.ForeignKey(Player, on_delete=models.CASCADE)
    date = models.DateTimeField("date")
    opening = models.ForeignKey(Opening, on_delete=models.CASCADE)

    result = models.CharField(max_length=10)
    white_elo = models.IntegerField()
    black_elo = models.IntegerField()
    number_of_moves = models.IntegerField()
    pgn = models.CharField(max_length=1536)
    site = models.CharField(max_length=100)