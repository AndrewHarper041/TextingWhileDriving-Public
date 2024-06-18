extends Camera3D

#camera variables
var leftWindowPos = Vector3(0, 5, 5) #fix later
var camSpeed = 2
var camRotationSpeed = 2

#pos = position, rot = rotation
var cameraPositions = {
	"frontPos": Vector3(-0.283, 1.199, 0.459),
	"backPos": Vector3(0, 2, 5),
	"leftWindowPos": Vector3(-0.285, 1.199, 0.459),
	"frontRot": Vector3(0, 0, 0),
	"leftSideRot": Vector3(0, 1.5, 0),
	"phoneViewPos": Vector3(-0.27, 1.199, 0.459),
	"phoneViewRot": Vector3(-.7, -0.85, 0)
}
var targetPos = cameraPositions["frontPos"]
var targetRot = cameraPositions["frontRot"]

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	handleCameraInput()
	if (transform.origin != targetPos):
		transform.origin = transform.origin.lerp(targetPos, delta * camSpeed)
	if (rotation != targetRot):
		rotation = rotation.lerp(targetRot, delta * camRotationSpeed)
		
func moveCameraPositionTarget(changeToPos):
	targetPos = changeToPos

func moveCameraRotationTarget(changeToRot):
	targetRot = changeToRot

func handleCameraInput():
	if Input.is_action_just_pressed("camera_rear_view"):
		if targetPos == cameraPositions["backPos"]: # TODO: consider addressing potential floating point percision issues with a dot product?
			moveCameraPositionTarget(cameraPositions["frontPos"]) #hitting the same button brings you back to the front pos, at any point in the lerp
		else:
			moveCameraPositionTarget(cameraPositions["backPos"])
		if targetRot !=  cameraPositions["frontRot"]:
			moveCameraRotationTarget(cameraPositions["frontRot"]) #if the rotation isn't front, make it front for this view
	if Input.is_action_just_pressed("camera_left_window_view"):
		if targetPos == cameraPositions["leftWindowPos"]:
			moveCameraPositionTarget(cameraPositions["frontPos"])
		else:
			moveCameraPositionTarget(cameraPositions["leftWindowPos"])
		if targetRot == cameraPositions["leftSideRot"]: # if it's looking front, make it look side
			moveCameraRotationTarget(cameraPositions["frontRot"])
		else: #reset the camera if it's already rotated
			moveCameraRotationTarget(cameraPositions["leftSideRot"]) #ugh these shouldn't be all independent, valid camera position/rotation pairs should be stored and rotated/moved to in one function TODO
	if Input.is_action_just_pressed("camera_phone_view"):
		if targetPos == cameraPositions["phoneViewPos"]:
			moveCameraPositionTarget(cameraPositions["frontPos"])
		else:
			moveCameraPositionTarget(cameraPositions["phoneViewPos"])
		if targetRot == cameraPositions["phoneViewRot"]:
			moveCameraRotationTarget(cameraPositions["frontRot"])
		else:
			moveCameraRotationTarget(cameraPositions["phoneViewRot"])
