extends CanvasLayer


func _ready() -> void:
	%Lose.hide()
	%Win.hide()
	%GoodEnding.hide()
	%BadEnding.hide()
	%Score.text = "0"


func _on_arcanoid_game_over(is_win: bool) -> void:
	if is_win:
		%Win.show()
		%GoodEnding.show()
	else:
		%Lose.show()
		%BadEnding.show()


func _on_arcanoid_score_changed(score: int) -> void:
	%Score.text = str(score)
