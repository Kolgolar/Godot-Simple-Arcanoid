"""
Скрипт Арканоида, обрабатывающий события, связанные с мячом и кирпичиками.
Перезапускает игру при нажатии на [R]
Сигнализирует о победе или проигрыше игрока и о текущем количестве очков
Определяет, когда шарик улетел вниз поля (т.е. игрок проиграл)
"""
extends Node2D

var score := 0 # Текущий счёт
var bricks_q := 0 # Общее число кирпичиков на поле, которые надо разрушить

signal game_over(is_win: bool) # Сигнал окончания игры
signal score_changed(score: int) # Сигнал изменения счёта

# Функция, выполняющаяся один раз при запуске игры
func _ready() -> void:
	randomize()
	$Ball.set_start_motion() # Сообщаем мячу о необходимости начать движение
	# Считаем количество кирпичиков на поле, присоединяем их сигнал уничтожения к
	# функции _on_brick_destroyed() внутри этого скрипта.
	for brick in %Bricks.get_children(): 
		brick.destroyed.connect(_on_brick_destroyed)
		bricks_q += 1

# Перезапускает игру, если пользователь нажал [R]
func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey and event.is_pressed() and event.keycode == KEY_R:
		get_tree().reload_current_scene()

# Проверяем, уничтожил ли игрок все кирпичики. Если да - активируем сигнал game_over
func _check_for_win():
	if score == bricks_q:
		game_over.emit(true)
		%Ball.queue_free()

# Функция, вызываемая при каждом уничтожении кирпичика.
# Увеличивает текущий счёт, сообщает об этом изменении через сигнал,
# а также вызывает функцию проверки окончания игры.
func _on_brick_destroyed():
	score += 1
	score_changed.emit(score)
	_check_for_win()

# Если мячик упал под поле.
func _on_pit_body_entered(body: Node2D) -> void:
	if body is ArcanoidBall:
		game_over.emit(false)
		%Ball.queue_free()
