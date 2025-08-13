extends StaticBody2D

signal destroyed


func _ready() -> void:
	var r := randf_range(0., 0.1)
	var g := randf_range(0.5, 1.0)
	var b := randf_range(0., 0.1)
	$Rectangle.color = Color(r, g, b)


func destroy():
	destroyed.emit()
	$CollisionShape2D.set_deferred("disabled", true)
	hide()
	if $AudioStreamPlayer.stream:
		$AudioStreamPlayer.play()
		await $AudioStreamPlayer.finished
	queue_free()
