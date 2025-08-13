class_name ArcanoidBall
extends RigidBody2D

@export var speed := 500 # Скорость мячика
@export var speed_add_step := 5 # На какое значение скорость растёт при каждом ударе
@export var max_speed := 1000 # Максимально возможная скорость мячика
# Максимально возможный угол отклонения от вертикальной оси,
# под которым мячик может начать движение в начале игры:
@export var max_start_angle := 80.
# Насколько сильно горизонтальная скорость мячика может увеличиться, если он
# ударился о край платформы.
@export var max_ball_speed_add := 200


# Функция, начинающая движение мячика в начале игры
func set_start_motion():
	var angle = deg_to_rad(max_start_angle)
	var direction := Vector2.UP.rotated(randf_range(-angle, angle))
	linear_velocity = direction * speed

# Функция, вызываемая, когда мячик столкнулся с каким-то телом
func _on_body_entered(body: Node) -> void:
	$AudioStreamPlayer.play()
	speed += speed_add_step # Увеличиваем скорость мячика
	if speed > max_speed: # Сохраняем скорость мячика не больше максимального допустимого значения
		speed = max_speed
	# Если столкнулись с платформой, то определяем, как нужно изменить направление движения
	# (ударились о левый край платформы -> мячик начинает сильнее двигаться влево после отскока)
	if body.has_method("get_add_velocity_x_mult"):
		var add_velocity_x_mult = body.get_add_velocity_x_mult(global_position)
		linear_velocity += add_velocity_x_mult * max_ball_speed_add
	# Если столкнулись с кирпичиком - уничтожаем его
	if body.has_method("destroy"):
		body.destroy()
	# Делаем так, чтобы скорость мячика была равна значению speed
	linear_velocity = linear_velocity.normalized() * speed
