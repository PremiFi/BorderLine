extends KinematicBody2D

var velocity = Vector2.ZERO
var speed = 300
const glockPath = preload("res://Glock.tscn")
onready var scene = get_tree().current_scene
onready var sprite = get_node("AnimatedSprite")
onready var holdState = get_node("HoldState")
onready var dropPoint = get_node("DropPoint")
onready var glockGround = scene.get_node("GlockGround")
onready var glockEquip = glockGround.get_node("GlockEquip")
onready var holdPoint = sprite.get_node("HoldPoint")

func spawnglock():
	var glockInstance = glockPath.instance()
	glockInstance.global_position = holdPoint.position
	sprite.add_child(glockInstance)




func _physics_process(delta):
	velocity.x = 0
	velocity.y = 0
	if Input.is_action_pressed("UP"):
		velocity.y -= speed
	if Input.is_action_pressed("DOWN"):
		velocity.y += speed
	if Input.is_action_pressed("LEFT"):
		velocity.x -= speed
	if Input.is_action_pressed("RIGHT"):
		velocity.x += speed
	if glockEquip.value == 1 and holdState.value == 1:
		spawnglock()
		yield(get_tree().create_timer(0.1), "timeout")
		glockEquip.value = 2
	
	if velocity != Vector2(0,0) and holdState.value == 0:
		sprite.animation = "Walk"
	if velocity == Vector2(0,0) and holdState.value == 0:
		sprite.animation = "Idle"
	if velocity == Vector2(0,0) and holdState.value == 1:
		sprite.animation = "LightHoldIdle"
	if velocity != Vector2(0,0) and holdState.value == 1:
		sprite.animation = "LightHoldWalk"
	
	
	
	self.look_at(get_global_mouse_position())
	velocity = move_and_slide(velocity, Vector2.UP)
