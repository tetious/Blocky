extends RigidBody

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

export var view_sensitivity = 0.45
var yaw = 0
var pitch = 0

onready var camera = get_node("head/camera")
onready var head = get_node("head")
onready var collider = get_node("collider")

func _ready():
	set_process_input(true)
	#set_fixed_process(true)

func _input(event):
	if event.type == InputEvent.MOUSE_MOTION:
		yaw = fmod(yaw - event.relative_x * view_sensitivity, 360)
		pitch = max(min(pitch - event.relative_y * view_sensitivity, 85), -85)
		head.set_rotation(Vector3(0, deg2rad(yaw), 0))
		camera.set_rotation(Vector3(deg2rad(pitch), 0, 0))

func _integrate_forces(state):
	var aim = camera.get_global_transform().basis

	var direction = Vector3()
	var up = 0
	if Input.is_action_pressed("move_forward"):
		direction -= aim[2] 
	if Input.is_action_pressed("move_back"):
		direction += aim[2]
	if Input.is_key_pressed(KEY_SPACE) and abs(get_linear_velocity().y) < 0.0001:
		print(get_linear_velocity().y)
		apply_impulse(Vector3(), Vector3(0,500,0))
#	if Input.is_key_pressed(KEY_UP):
#		motion += forward
#	if Input.is_key_pressed(KEY_DOWN):
#		motion -= forward
	
	apply_impulse(Vector3(), Vector3(direction.x,up,direction.z).normalized() * 20)

func _process():
	pass