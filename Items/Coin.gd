extends Node2D



func _on_Area2D_body_entered(body):
	get_tree().call_group("Gamestate", "coin_pickup")
	$AnimationPlayer.play("die")
	$CoinSFX.play()
	$Area2D/CollisionShape2D.set_deferred("disabled", true)


func die():
	queue_free()
