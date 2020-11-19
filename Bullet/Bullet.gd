extends Sprite

var velocity  = Vector2(1,0)
var speed     = 250
var look_once = true

func _ready():
	Global.g_bulletcount += 1

func _exit_tree():
	Global.g_bulletcount -= 1

#------------------------------------------------------------------------------
func _process(delta):
	if look_once:
		look_at( get_global_mouse_position() )
		look_once = false
		
	global_position += velocity.rotated(rotation) * speed * delta
#------------------------------------------------------------------------------
# when bullet leaves screen , need to destroy node/object
func _on_VisibilityNotifier2D_screen_exited():
	Global.g_bulletmiscount += 1
	queue_free()
#==============================================================================
