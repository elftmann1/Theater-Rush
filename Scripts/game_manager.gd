extends Node

signal start_game

@onready var timer_text = $TimerText
@onready var timer = $Timer
@onready var restart_button = %RestartButton/Button

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	restart_button.disabled = true
	restart_button.visible = false
	start_game.connect(self.start_timer)
	restart_button.pressed.connect(self.restart_button_pressed)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	timer_text.text = "Timer: " + str(int(timer.time_left));

func start_timer():
	timer.set_wait_time(60);
	timer.start();

func _on_player_is_moving() -> void:
	start_game.emit()

func _on_player_player_died() -> void:
	restart_button.disabled = false
	restart_button.visible = true
	timer.stop()

func restart_button_pressed():
	get_tree().reload_current_scene()
