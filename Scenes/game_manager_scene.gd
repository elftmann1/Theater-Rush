extends Node

@onready var timer = $Timer
@onready var timer_text = $TimerText
@onready var score_text = $CounterText
@onready var restart_button = %RestartButton/Button

func _ready():
	restart_button.disabled = true
	restart_button.visible = false

	# Connect to global signals
	GameManager.start_game.connect(start_timer)
	GameManager.player_died.connect(on_player_died)

func _process(_delta):
	timer_text.text = "Timer: " + str(int(timer.time_left))
	score_text.text = "Score: " + str(GameManager.score)

func start_timer():
	timer.wait_time = GameManager.game_time
	timer.start()

func on_player_died():
	restart_button.disabled = false
	restart_button.visible = true
	timer.stop()

func _on_RestartButton_pressed():
	get_tree().reload_current_scene()
