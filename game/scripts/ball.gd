class_name ArcanoidBall
extends RigidBody2D

@export var speed := 500
@export var speed_add_step := 5
@export var max_speed := 1000
@export var min_start_angle := 10.


func set_start_motion():
	var min_angle_rad = deg_to_rad(min_start_angle)
	var direction := Vector2.LEFT.rotated(randf_range(min_angle_rad, PI - min_angle_rad))
	linear_velocity = direction * speed


func _on_body_entered(body: Node) -> void:
	$AudioStreamPlayer.play()
	speed += speed_add_step
	if speed > max_speed:
		speed = max_speed
	if body.has_method("get_add_velocity"):
		var add_velocity = body.get_add_velocity(global_position)
		linear_velocity += add_velocity
	if body.has_method("destroy"):
		body.destroy()
	linear_velocity = linear_velocity.normalized() * speed
