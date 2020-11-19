extends Sprite


var speed = 200
var velocity = Vector2()
var bullet = preload("res://Bullet/Bullet.tscn")
var can_shoot = true

#------------------------------------------------------------------------------
func _ready():
	Global.node_player = self
	Global.g_player_hp = 1000

func _exit_tree():
	Global.node_player = null

#------------------------------------------------------------------------------
func _process(delta):
	
	# read keyboard and mouse info
	velocity.x = int( Input.is_action_pressed("ui_right") ) - int( Input.is_action_pressed("ui_left") )
	velocity.y = int( Input.is_action_pressed("ui_down") )  - int( Input.is_action_pressed("ui_up") )
	velocity = velocity.normalized()
	
	look_at( get_global_mouse_position() )
	
	# move player
	self.global_position += speed * velocity * delta
	self.global_position.x = clamp(self.global_position.x, 0+10 , 1280-10)
	self.global_position.y = clamp(self.global_position.y, 0+10 , 720-10)

	# shoot
	if Input.is_action_pressed("click") and ( Global.node_creation_parent != null ) and can_shoot :
		Global.instance_node( bullet, global_position, Global.node_creation_parent )
		Global.playsound("Shoot")
		can_shoot = false
		if Global.g_bulletcount > 20 :      # nr of bullets in field determines shoot(reload)rate
			$Reloadspeed.start(0.2)
		elif Global.g_bulletcount > 10 :
			$Reloadspeed.start(0.1)
		else :
			$Reloadspeed.start(0.05)

#------------------------------------------------------------------------------
# limits the shooting rate
func _on_Reloadspeed_timeout():
	can_shoot = true

# when enemy hits player, health point goes down.
func _on_Area2D_area_entered(area):
	if area.is_in_group("Player_damager"):
		Global.g_player_hp -=1
	
#==============================================================================
