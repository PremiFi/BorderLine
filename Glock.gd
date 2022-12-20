extends Sprite


onready var scene = get_tree().current_scene
onready var glockGround = scene.get_node("GlockGround")
onready var glockEquip = glockGround.get_node("GlockEquip")
onready var player = scene.get_node("Player")
onready var holdState = player.get_node("HoldState")
onready var gunBarrel = self.get_node("GunBarrel")
var bulletSpeed = 1000
const bulletPath = preload("res://Bullet.tscn")
var can_fire = true
var fire_rate = 0.3

func shoot():
	can_fire = false
	var bulletInstance = bulletPath.instance()
	bulletInstance.position = gunBarrel.get_global_position() #Change bullet to whatever you have your position2d named
	bulletInstance.rotation_degrees = rotation_degrees
	bulletInstance.apply_impulse(Vector2(), Vector2(bulletSpeed, 0).rotated(player.rotation))
	get_tree().get_root().add_child(bulletInstance)
	yield(get_tree().create_timer(fire_rate), "timeout")
	can_fire = true
	
	
	
func _process(delta):
	
	
	#deleting the glock if its dropped
	if Input.is_action_pressed("DROP") and glockEquip.value == 0:
		yield(get_tree().create_timer(0,05), "timeout")
		queue_free()
	
	if Input.is_action_pressed("SHOOT") and can_fire:
		shoot()
		print("shot")
   


