extends KinematicBody

# This Script Provides Gravity For Objects.

var gravity: int = 20
var snap: Vector3 = Vector3()
var gravityVec: Vector3 = Vector3()

func _physics_process(delta):
	if is_on_floor():
		snap = -get_floor_normal()
		gravityVec = Vector3.ZERO
	else:
		snap = Vector3.DOWN
		gravityVec += Vector3.DOWN * gravity * delta

	# warning-ignore:return_value_discarded
	move_and_slide_with_snap(gravityVec, snap, Vector3.UP)

