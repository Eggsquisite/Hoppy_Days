extends Node2D

var lives = 3
var coins = 0
var coins_To_Life = 10

func _ready():
	add_to_group("Gamestate")
	update_GUI()


func hurt():
	lives -= 1
	$Player.hurt()
	update_GUI()
	
	if lives < 0:
		end_game()


func coin_pickup():
	coins += 1
	update_GUI()
	if coins % coins_To_Life == 0:
		life_up()


func life_up():
	lives += 1
	update_GUI()

func update_GUI():
	get_tree().call_group("GUI", "update_gui", lives, coins)


func end_game():
	get_tree().change_scene("res://Levels/GameOver.tscn")
