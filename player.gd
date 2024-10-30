extends Area2D

@onready var screensize = get_viewport_rect().size

var MAXVELOCITY = 150
@export var velocity = Vector2.ZERO
var acceleration = 150

var growthRate = .012
var decayRate = 3
signal died
signal ateEnemy

func start() -> void:
	position = screensize / 2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	apply_input(delta)
	apply_friction(delta)
	clamp_velocity()
	update_position(delta)
	check_bounds()

func apply_input(delta: float) -> void:
	var input = Input.get_vector("Left", "Right", "Up", "Down")
	#print(input)
	velocity += input * delta * acceleration


func apply_friction(delta : float) -> void:
	if velocity.length() > 0:
		velocity -= .6 * delta * velocity

func clamp_velocity() -> void:
	if velocity.length() > MAXVELOCITY:
		velocity = velocity.normalized() * MAXVELOCITY

func update_position(delta: float) -> void:
	position += velocity * delta
	#print(position, velocity, delta)

func check_bounds() -> void:
	position.x = clamp(position.x, 0, screensize.x)
	position.y = clamp(position.y, 0, screensize.y)
	
	if position.x == 0 or position.x == screensize.x:
		velocity.x = 0
	if position.y == 0 or position.y == screensize.y:
		velocity.y = 0
	


func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("Enemies"):
		if area.scale > scale:
			died.emit()
		else:
			ateEnemy.emit(area)


func _on_ate_enemy(area: Area2D) -> void:
	#var growth = area.scale / scale * growthRate
	var growth = scale.normalized() * pow((area.scale / scale).length_squared(), decayRate) * growthRate

	#print(str("Growth: ", growth))
	scale += growth
	
	area.hide()

	
