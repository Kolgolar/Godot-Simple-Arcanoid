extends CharacterBody2D

@export var speed := 500

@export var max_ball_speed_add := 200

@onready var start_pos := position
@onready var size = $CollisionShape2D.shape.size

func _physics_process(delta: float) -> void:
	var direction := 0
	direction = Input.get_axis("ui_left", "ui_right")
	velocity.x = speed * direction
	move_and_slide()
	position.y = start_pos.y


func get_add_velocity(pos: Vector2) -> Vector2:
	var pos_diff := pos - global_position
	var speed_mult: float = pos_diff.x / (size.x / 2)
	print(pos_diff.x)
	print(speed_mult)
	print("------")
	return Vector2(speed_mult * max_ball_speed_add, 0)
