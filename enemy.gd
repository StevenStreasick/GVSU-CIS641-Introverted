extends Area2D

var rng = RandomNumberGenerator.new()
var rightSide = rng.randi_range(0, 1)

var sideSign = (1 - rightSide) * 2 - 1


@export var velocity = rng.randi_range(50, 200)
@onready var screensize = get_viewport_rect().size

func start() -> void:
	#TODO: Scale the radius by the base size of the enemy?
	var x = (rightSide * screensize.x) #+ scale.x / 2
	var y = (rng.randf_range(0, screensize.y)) #0 + scale.y / 2, screensize.y - scale.y
	position = Vector2(x, y)
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.x += delta * velocity * sideSign
	
