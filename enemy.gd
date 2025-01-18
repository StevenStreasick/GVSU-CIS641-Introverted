extends RigidBody2D
class_name enemy

var rng = RandomNumberGenerator.new()

var TURNSPEED = 15 #degrees/sec

var main;
var player;
var enemyController;
var camera;
var viewportSize;
var velocityRange;

func initialize(main: Node2D) -> bool:
	
	self.main = main
	player = main.get_node("Player")
	enemyController = main.get_node("EnemyController")
	camera = main.get_node("Camera2D")
	viewportSize = camera.get_viewport_rect().size
	velocityRange = enemyController.getEnemyVelocity()
	
	return true

func spawn() -> bool:
	return true
