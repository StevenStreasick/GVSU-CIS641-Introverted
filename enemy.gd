extends Area2D

var rng = RandomNumberGenerator.new()
var rightSide = rng.randi_range(0, 1)

var sideSign = (1 - rightSide) * 2 - 1

var TURNSPEED = 15 #degrees/sec
#TODO: I believe that my easiest path forward will be to use the default viewport, and resize that using the 
#	size function. Granted, I will have to take the scalar and adjust it based on that.
#@export var velocity = rng.randi_range(50, 200)


@onready var main = get_parent()
@onready var player = main.get_node("Player")
@onready var enemyController = main.get_node("EnemyController")
@onready var camera = main.get_node("Camera2D")
@onready var velocityRange: Vector2 = enemyController.getEnemyVelocity()

@onready var velocity = Vector2(randf_range(velocityRange.x, velocityRange.y) * sideSign, 0)
@onready var velocityLength = velocity.length()

func start() -> void:
	var viewportSize = camera.get_viewport_rect().size
	var screensize = viewportSize / camera.zoom + camera.position
	#TODO: Scale the radius by the base size of the enemy?
	var x = (rightSide * screensize.x) #+ scale.x / 2
	var y = (rng.randf_range(0, screensize.y)) #0 + scale.y / 2, screensize.y - scale.y
	position = Vector2(x, y)

func get_velocity_for_targeting_player(delta: float, playerPos: Vector2) -> Vector2:
	# Calculate direction vector to the player
	var dx = playerPos.x - position.x
	var dy = playerPos.y - position.y
	
	var enemyAngle = velocity.angle()
	
	# Calculate the angle to the player
	var targetAngle = atan2(dy, dx) * (180 / PI)  # Convert to degrees

	# Calculate the angle difference and clamp it to the turn speed
	var angleDifference = targetAngle - enemyAngle
	angleDifference = (fmod(angleDifference + 180, 360) - 180)  # Normalize to range -180 to 180

	# Limit the turn based on turn speed and deltaT
	var maxTurn = TURNSPEED * delta
	if abs(angleDifference) > maxTurn:
		angleDifference = abs(maxTurn) * sign(angleDifference)
	
	# Update the current angle
	var newAngle = enemyAngle + angleDifference

	# Calculate the velocity components based on the adjusted angle
	var rads = newAngle * (PI / 180.0)
	var velocityX = cos(rads) * velocity.x
	var velocityY = sin(rads) * velocity.y

	return Vector2(velocityX, velocityY)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var playerPos = player.position
	var distanceToPlayer = position.distance_to(playerPos)
	var sight = enemyController.getEnemySight()
	
	if distanceToPlayer < sight:
		pass
		#velocity = get_velocity_for_targeting_player(delta, playerPos) 
		#print(velocity.normalized().y)

	position += delta * velocity
	#print(position)
	#pass
