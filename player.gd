extends CharacterBody2D

@onready var screensize = get_viewport_rect().size

var MAXVELOCITY = 250
var acceleration = 150

var growthRate = 0.012
var decayRate = 3
signal died
signal ateEnemy

@onready var main = get_parent()
@onready var camera = main.get_node("Camera2D")

@onready var viewportSize = camera.get_viewport_rect().size
@onready var offset = camera.offset

func init() -> String:
	return "Hello"

func start() -> void:
	position = Vector2.ZERO
	velocity = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	apply_input(delta)
	apply_friction(delta)
	clamp_velocity()
	move_player(delta)
	check_bounds()

func apply_input(delta: float) -> void:
	var input = Input.get_vector("Left", "Right", "Up", "Down")
	velocity += input * delta * acceleration

func apply_friction(delta: float) -> void:
	if velocity.length() > 0:
		velocity -= 0.6 * delta * velocity

func clamp_velocity() -> void:
	if velocity.length() > MAXVELOCITY:
		velocity = velocity.normalized() * MAXVELOCITY

func move_player(delta: float) -> void:
	var collision = move_and_collide(velocity * delta)
	
	if collision:
		var collider = collision.get_collider()
		#print("Collision")
		if !collider:
			return
		if !collider.is_in_group("Enemies"):
			return
		
		if collider.scale > scale:
			died.emit()
		else:
			ateEnemy.emit(collider)

func get_lower_bounds() -> Vector2:
	var screensize = viewportSize / camera.zoom
	return offset - (screensize / 2)

func get_upper_bounds() -> Vector2:
	var screensize = viewportSize / camera.zoom
	return (screensize / 2) + offset

func check_bounds() -> void:
	var lowerbound: Vector2 = get_lower_bounds()
	var upperbound: Vector2 = get_upper_bounds()
	
	position.x = clamp(position.x, lowerbound.x, upperbound.x)
	position.y = clamp(position.y, lowerbound.y, upperbound.y)
	
	if position.x <= lowerbound.x or position.x >= upperbound.x:
		velocity.x = 0
	if position.y <= lowerbound.y or position.y >= upperbound.y:
		velocity.y = 0

#func _on_area_entered(area: Area2D) -> void:
	

func _on_ate_enemy(area: PhysicsBody2D) -> void:
	var growth = scale.normalized() * pow((area.scale / scale).length_squared(), decayRate) * growthRate
	scale += growth
	area.queue_free()
