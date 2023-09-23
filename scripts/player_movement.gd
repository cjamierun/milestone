extends CharacterBody3D

const SPEED = 5.0
const JUMP_VELOCITY = 4.5

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _physics_process(delta):
	if not is_on_floor():
		velocity.y -= gravity * delta

	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var input_dir = Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	var rotation = transform.basis.get_euler()

	var forward = Vector3(0, 0, -1).rotated(Vector3(0, 1, 0), rotation.y)
	var right = Vector3(-1, 0, 0).rotated(Vector3(0, 1, 0), rotation.y)

	var movement_vector = forward * input_dir.y + right * input_dir.x

	velocity.x = movement_vector.x * SPEED
	velocity.z = movement_vector.z * SPEED

	move_and_slide()
