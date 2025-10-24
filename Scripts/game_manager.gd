# res://scripts/GameManager.gd
extends Node

signal start_game
signal player_died

var score: int = 0
var game_time: float = 60.0

func reset():
	score = 0

func add_score(points: int):
	score += points
