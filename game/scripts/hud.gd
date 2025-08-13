extends CanvasLayer

# Прячим все надписи и картинки в начале игры
func _ready() -> void:
	%Lose.hide()
	%Win.hide()
	%GoodEnding.hide()
	%BadEnding.hide()
	%Score.text = "0"

# Вызывается, если игровое поле сообщила об окончании игры
# Выводит поздравление с победой или сообщает о поражении
func _on_arcanoid_game_over(is_win: bool) -> void:
	if is_win:
		%Win.show()
		%GoodEnding.show()
	else:
		%Lose.show()
		%BadEnding.show()

# Вызывается при изменении счёта игрока.
# Отображает счёт (очки).
func _on_arcanoid_score_changed(score: int) -> void:
	%Score.text = str(score)
