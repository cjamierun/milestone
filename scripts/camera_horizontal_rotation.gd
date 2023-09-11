extends Camera3D

@export var target_path: NodePath
@export var offset: Vector3
var target: Node3D
var distance: float
var rotation_speed: float = 1.0

func _ready():
	target = get_node(target_path)
	distance = (global_transform.origin - target.global_transform.origin).length()

func _process(delta):
	var rotation_dir = Vector3(0, 1, 0)
	var rotation_angle = rotation_speed * delta
		
	# Move the world so that the target is at the origin, rotate the camera, then move the world back
	var target_pos_with_offset = target.global_transform.origin + offset
	global_transform.origin -= target_pos_with_offset
	global_transform = global_transform.rotated(rotation_dir, rotation_angle)
	global_transform.origin += target_pos_with_offset

	look_at(target_pos_with_offset, Vector3.UP)
