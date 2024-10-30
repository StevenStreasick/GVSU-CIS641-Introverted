extends Node2D

var enemy = preload("res://enemy.tscn")

@onready var enemy_controller = get_node("EnemyController")

@onready var start_button = $CanvasLayer/CenterContainer/Start
@onready var game_over = $CanvasLayer/CenterContainer/GameOver

var rng = RandomNumberGenerator.new()
var DEFAULTSPRITESIZE = 64
var isGameActive = false
var score: float = 0


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
	
func getEnemyScaleFromRange(enemySizeRange: Vector2) -> Vector2:
	
	return Vector2.ONE * rng.randf_range(enemySizeRange.x, enemySizeRange.y)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Player.hide()
	start_button.show()
	game_over.hide()
	$CanvasLayer/UI.hide()



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var spawnrate = enemy_controller.getNumEnemies()
	if isGameActive:	
		if rng.randf() < spawnrate * delta:
			#print("Spawning an Enemy")
			var e = enemy.instantiate()
			e.scale = getEnemyScaleFromRange(enemy_controller.getEnemySize())
			add_child(e)
			#print("Created new enemy")


func _on_player_ate_enemy(area : Area2D) -> void:
	score += area.scale.length() * DEFAULTSPRITESIZE 
	$CanvasLayer/UI.updateScore(score)
	
func get_score() -> float:
	return score
