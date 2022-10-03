extends "GravityObj.gd";

onready var _RayCast: RayCast = $RayCast;
onready var AnimPlayer: AnimationPlayer = $AnimationPlayer;

var _Player = null; # Class Instance
var IsDead: bool = false;
const MOVE_SPEED: int = 3;

func _ready() -> void:
	AnimPlayer.play("EnemyWalk");
	add_to_group("zombies");

func _physics_process(delta: float) -> void:
	if IsDead or _Player == null:
		return;

	var vec_to_player = _Player.translation - translation;
	vec_to_player = vec_to_player.normalized();
	_RayCast.cast_to = vec_to_player * 1.5;

	move_and_collide(vec_to_player * MOVE_SPEED * delta);

	if _RayCast.is_colliding():
		var coll = _RayCast.get_collider();
		if coll != null and coll.name == "Player":
			coll.kill();

func kill() -> void:
	# Only Die If Not Dead
	if not IsDead:
		IsDead = true;
		AnimPlayer.play("EnemyDie");
		set_collision_mask_bit(2, false); # Disable Collision With Player

func set_player(p):
	_Player = p;

