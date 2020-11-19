extends Sprite

var speed = 60
var velocity = Vector2()
var stun = false
var health = 2
var ani_dying: bool = false

var dodging  : bool = false
var dogdedirangle:float

#------------------------------------------------------------------------------
func _ready():
	$mytween.interpolate_property(self, "scale", Vector2(1.5, 1.5), Vector2(0,0) , 0.5, Tween.TRANS_BACK,Tween.EASE_OUT_IN  )
	Global.g_enemycount += 1
#------------------------------------------------------------------------------
func _process(delta):

	if ( Global.node_player != null ):
		if ( stun == false ): 
			velocity = global_position.direction_to(Global.node_player.global_position)
			if dodging:
				global_position += velocity.rotated(dogdedirangle) * (speed * 1.5 ) * delta
			else:
				global_position += velocity * speed * delta
		else : # stun == true
			velocity = lerp(velocity, Vector2(0,0), 0.3 )
			global_position += velocity * speed * delta

	if ani_dying:
		if $mytween.is_active() == false:
			Global.g_enemycount -= 1
			queue_free()
	else:
		if health <= 0:
			$mytween.start()
			modulate = Color("a2f906")
			ani_dying = true

#------------------------------------------------------------------------------
func _on_Hitbox_area_entered(area):
	if area.is_in_group("Enemy_damager"):
		if ani_dying == false :
			modulate = Color.white                # stun enemy
			velocity = -velocity * 6
			stun = true
			health -= 1
			scale -= Vector2(0.3 ,0.3)            # when hit shrink
			speed += 20                           # when hit(shrunk) move faster
			Global.playsound("Hit")
			$Timer_stun.start()
		area.get_parent().queue_free()            # destroy bullet that hit us
		# need getparent because var 'area' is just hitbox

#------------------------------------------------------------------------------
# called when bullet comes close to enemy 
func _on_Radarzone_area_entered(area):
	if dodging == false :
		if area.is_in_group("Enemy_damager"):
			#modulate = Color.magenta
			dodging = true
			# pick random dodge direction , eg. left or right
			dogdedirangle = rand_range( 0.45 * PI , 0.45 * PI )   # ~ 90 degree
			if dogdedirangle > (0.5 * PI) :
				dogdedirangle *= -1                     # flip angle to other side
#------------------------------------------------------------------------------
func _on_Radarzone_area_exited(area):
	#modulate = Color("a2f906")
	dodging = false
#-------------------------------------
func _on_Timer_stun_timeout():
	modulate = Color("a2f906")
	stun = false
#==============================================================================


