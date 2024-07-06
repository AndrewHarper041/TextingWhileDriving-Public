extends Area3D

# Direction of stop sign CollisionShape3D
var stop_sign_unit_vector: Vector3
var contained_body
const ENFORCEMENT_THRESHOLD = -5.0
var min_stop_sign_projected_speed: float
#@onready var traffic_violation_label = $car/Hud/traffic_violation
@onready var collision_shape_3d = $CollisionShape3D

# Called when the node enters the scene tree for the first time.
func _ready():
	# TODO - obtain actual normal vector that accounts for rotation etc.
	stop_sign_unit_vector = collision_shape_3d.global_transform.basis.z

# Calculate body speed perpendicular to stop sign collision box
func get_body_projected_speed(body):
	return stop_sign_unit_vector.dot(contained_body.get_linear_velocity())

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if contained_body:
		var stop_sign_projected_speed: float = get_body_projected_speed(contained_body)
		print("Projected Speed: " + str(stop_sign_projected_speed))
		min_stop_sign_projected_speed = min(min_stop_sign_projected_speed, stop_sign_projected_speed)

func _on_body_entered(body):
	contained_body = body
	min_stop_sign_projected_speed = get_body_projected_speed(contained_body)
	
func _on_body_exited(body):
	if min_stop_sign_projected_speed < ENFORCEMENT_THRESHOLD:
		print("=========== TRAFFIC VIOLATION !!! ===========")
		print("Body min speed: " + str(min_stop_sign_projected_speed))
		body.get_node("Hud/traffic_violation").text = "TRAFFIC VIOLATION!"

	contained_body = null
	min_stop_sign_projected_speed = 0.0
