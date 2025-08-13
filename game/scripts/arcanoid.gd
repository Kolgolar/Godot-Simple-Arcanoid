extends Node2D

var score := 0
var bricks_q := 0

signal game_over(is_win: bool)
signal score_changed(score: int)


func _ready() -> void:
	$Ball.set_start_motion()
	for brick in %Bricks.get_children():
		brick.destroyed.connect(_on_brick_destroyed)
		bricks_q += 1


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey and event.is_pressed() and event.keycode == KEY_R:
		get_tree().reload_current_scene()


func _check_for_win():
	if score == bricks_q:
		game_over.emit(true)
		%Ball.queue_free()


func _on_brick_destroyed():
	score += 1
	score_changed.emit(score)
	_check_for_win()


func _on_pit_body_entered(body: Node2D) -> void:
	if body is ArcanoidBall:
		game_over.emit(false)
		%Ball.queue_free()
