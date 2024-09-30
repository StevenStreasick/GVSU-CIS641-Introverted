extends Node2D

var enemy = preload("res://enemy.tscn")

@onready var start_button = $CanvasLayer/CenterContainer/Start
@onready var game_over = $CanvasLayer/CenterContainer/GameOver

var rng = RandomNumberGenerator.new()
var SPAWNRATE = 1
var DEFAULTSPRITESIZE = 64
var isGameActive = false
var score

func startGame() -> void:
	isGameActive = true
	score = 0
	
	$Player.show()
	$Player.start()
	start_button.hide()
	game_over.hide()
	$CanvasLayer/UI.show()
	$CanvasLayer/UI.updateScore(score)

func endGame() -> void:
	isGameActive = false
	$Player.hide()
	get_tree().call_group("Enemies", "queue_free")
	game_over.show()	
	await get_tree().create_timer(2).timeout
	game_over.hide()
	start_button.show()
	
	

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#add_child(player.instantiate())
	$Player.hide()
	start_button.show()
	game_over.hide()
	$CanvasLayer/UI.hide()
	print("Showing the start_button")



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if isGameActive:	
		#var e = enemy.instantiate()
		#add_child(e)
	
		if  rng.randf() < SPAWNRATE * delta:
			var e = enemy.instantiate()
			add_child(e)
			#print("Created new enemy")
			#TODO: Create a death of the enemy event


func _on_player_ate_enemy(area : Area2D) -> void:
	score += area.scale.length() * DEFAULTSPRITESIZE 
	$CanvasLayer/UI.updateScore(score)
	
