extends Camera3D

var isFrontFacing = true
var frontPos = Vector3(-0.283, 1.199, 0.459) #these numbers are magical in nature
var backPos = Vector3(0, 2, 5)
var targetPos = frontPos
var camSpeed = 2

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("camera_flip"):
		moveCamera(delta)
	if (transform.origin != targetPos):
		transform.origin = transform.origin.lerp(targetPos, delta * camSpeed)
		
func moveCamera(delta):
	if (isFrontFacing):
			isFrontFacing = false
			targetPos = backPos
	else:
		isFrontFacing = true
		targetPos = frontPos
	transform.origin = transform.origin.lerp(targetPos, delta * camSpeed)
