extends Node2D

signal gameStarted 
signal gameEnded

var barrier = preload("res://Barrier.tscn")
var spikewall = preload("res://spike_wall.tscn")
var invincibility = preload("res://invincibilityPowerup.tscn")
var wall_consumption = preload("res://wallPowerup.tscn")

@onready var frame_rate_controller = get_node("FrameRateController")
@onready var enemy_controller = get_node("EnemyController")

var enemies = [
	preload("res://horizontal_enemy.tscn"),
	preload("res://vertical_enemy.tscn")
]

@onready var start_button = $CanvasLayer/CenterContainer/Start
@onready var game_over = $CanvasLayer/CenterContainer/GameOver

var rng = RandomNumberGenerator.new()
var DEFAULTSPRITESIZE = 64
var isGameActive = false
var score: float = 0
var time: float = 0

var fileNumber = 0
var filePath = OS.get_user_data_dir() + "/sas_data/"
#var filePath = "~/Documents/School/GVSU/2024FallSemester/CIS 641/Fishy Data/SAS Data/"
#NOTE: You must press the X on the window instead of stopping the game so that the file will properly close.
var file = FileAccess.open(filePath + "Run " + str(fileNumber) + ".txt", FileAccess.WRITE)

func startGame() -> void:
	gameStarted.emit()
	isGameActive = true
	score = 0
	
	$Player.show()
	$Player.start()
	start_button.hide()
	game_over.hide()
	$CanvasLayer/UI.show()
	$CanvasLayer/UI.updateScore(score)

func endGame() -> void:
	gameEnded.emit()
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
	#var b = barrier.instantiate()
	#var s = spikewall.instantiate()
	#var i = invincibility.instantiate()
	#var w = wall_consumption.instantiate()
	#b.position = Vector2(250, 250)
	#s.position = Vector2(-250, 250)
	#i.position = Vector2(-250, -250)
	#w.position = Vector2(250, -250)
	#add_child(b)
	#add_child(s)
	#add_child(i)
	#add_child(w)

func writeToFile(currentTime, framerate, happiness, zoom, numEnemies, enemySize, enemyVelocity, enemySight) -> void:
	var concatString = str("%2.3f" % currentTime) + "," + str("%2.3f" % framerate) + "," \
	+ str("%2.3f" % happiness)  + "," + str("%2.3f" % zoom)  + "," + str("%2.3f" % numEnemies) \
	 + "," + str(enemySize) + "," + str(enemyVelocity)  + "," + str("%2.3f" % enemySight) + "\n"
	
	file.store_string(concatString)
	#NOTE: # enemies and enemySight are fixed variables

func spawnEnemy() -> PhysicsBody2D:
	var length = enemies.size()
	var enemyIndex = rng.randi_range(0, length - 1) #randi_range is fully inclusive
	
	var e = enemies[enemyIndex].instantiate()
	
	e.scale = getEnemyScaleFromRange(enemy_controller.getEnemySize())
	e.initialize(self)
	e.spawn()
	add_child(e)
	
	return e
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var spawnrate = enemy_controller.getNumEnemies()
	if !isGameActive:
		return

	if (time < 45):
		if (time > 15):
			var framerate = Engine.get_frames_per_second()
			var happiness = frame_rate_controller.getHappiness()
			var zoom = frame_rate_controller.getZoom()
			
			var numEnemies = enemy_controller.getNumEnemies()
			var enemySize = enemy_controller.getEnemySize()
			var enemyVelocity = enemy_controller.getEnemyVelocity()
			var enemySight = enemy_controller.getEnemySight()
			
			writeToFile(time, framerate, happiness, zoom, numEnemies, enemySize, enemyVelocity, enemySight)
		time += delta
	else:
		print("Times up")	
		
	if rng.randf() < spawnrate * delta:
		print("Spawning an enemy")
		spawnEnemy()
		
func _on_player_ate_enemy(area : PhysicsBody2D) -> void:
	score += area.scale.length() * DEFAULTSPRITESIZE 
	$CanvasLayer/UI.updateScore(score)
	
func get_score() -> float:
	return score
