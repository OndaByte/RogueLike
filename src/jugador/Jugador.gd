extends CharacterBody3D

const SPEED = 2.0
const JUMP_VELOCITY = 4.5
const CAM_VEL = 0.05
const MAX_ZOOM = 5
const MIN_ZOOM = 2
const VEL_ZOOM = 0.05
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
@onready var animation_player = $modelo/player/AnimationPlayer
@onready var player = $modelo
@onready var camara = $objetivo/camara
@onready var objetivo = $objetivo

var en_mov = false
var zoom = 3

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var input_dir = Input.get_vector("izquierda", "derecha", "adelante", "atras")
	
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	if Input.is_action_pressed("cam_der"):
		objetivo.rotate_y(CAM_VEL)
	if Input.is_action_pressed("cam_izq"):
		objetivo.rotate_y(-CAM_VEL)
	if Input.is_action_just_released("cam_zoom") and zoom > MIN_ZOOM:
		zoom -= VEL_ZOOM
		camara.position = Vector3(0,0,zoom)
	if Input.is_action_just_released("cam_unzoom") and zoom < MAX_ZOOM:
		zoom += VEL_ZOOM
		camara.position = Vector3(0,0,zoom)
		
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
		player.look_at(direction + position)
		if !en_mov:
			en_mov = true
			animation_player.play("walk")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
		if en_mov:
			en_mov = false
			animation_player.play("idle")
	camara.look_at(position)

	move_and_slide()
