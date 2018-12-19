extends KinematicBody2D

# 2019-01-05 acodemia.pl

var health = 100
var on_scene = false

var motion_speed = 200
var shooting = false
var bullet_data = preload("res://bullet/Bullet.tscn")


export (float) var created_bullet_scale_factor = 1
export (float) var created_bullet_speed = 400
export (float) var bullet_caliber = 2


func _ready():
	set_physics_process(true)
	#set_process(true)
	pass
	
	
#func _process(delta):
#	pass
	
	
func _physics_process(delta):
	
	if(health <= 0):
		self.queue_free()
		
	var motion = Vector2()
	
	if (Input.is_action_pressed("ui_up")):
		motion += Vector2(0, -1)
	if (Input.is_action_pressed("ui_down")):
		motion += Vector2(0, 1)
	if (Input.is_action_pressed("ui_left")):
		motion += Vector2(-1, 0)
	if (Input.is_action_pressed("ui_right")):
		motion += Vector2(1, 0)
	if (Input.is_action_pressed("Shoot")):
		if(shooting):
			createBullet()
			pass
		pass
	
	motion = motion.normalized() * motion_speed * delta
	motion = move_and_collide(motion)
	pass
	
	
func createBullet():
	
	# tworzymy pocisk
	var bullet = bullet_data.instance()
	# ustawiamy pocisk na pozycji startowej
	bullet.global_position= $BulletPosition2D.global_position
	# ustawiamy skalę
	bullet.global_scale = global_scale * created_bullet_scale_factor
	# prędkość pocisku
	bullet.bullet_speed = created_bullet_speed
	# kaliber - siła rażenia
	bullet.caliber = bullet_caliber
	# dodajemy pocisk do sceny (względem root'a sceny - Level_a)
	get_parent().get_parent().add_child(bullet)
	
	shooting = false
	pass
	
	
func _on_TimerShoot_timeout():
	shooting = true
	pass
	
	
func update_health(damage):
	health -= damage
	print(health)
	pass
	
	
func _on_VisibilityNotifier2D_screen_entered():
	on_scene = true
	pass
	
	
func _on_VisibilityNotifier2D_screen_exited():
	on_scene = false
	pass
	
#func _process(delta):
#	look_at(get_global_mouse_position())
	
