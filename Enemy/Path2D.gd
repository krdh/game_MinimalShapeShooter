extends Path2D

# Under Development,  not used in game yet  !!!!

onready var flying = get_node("PathFollow2D")

func _ready():
	set_process(true)
	
	var mytween = Tween.new()
	self.add_child(mytween)
	mytween.interpolate_property(flying, "unit_offset", 0,1,20, mytween.TRANS_LINEAR, mytween.EASE_IN_OUT)
	mytween.set_repeat(true)
	mytween.start()

func _process(delta):
	pass
	#flying.set_offset(flying.get_offset() + 350 * delta)

#global_position.direction_to(Global.node_player.global_position)

#Global.instance_node( bullet, global_position, Global.node_creation_parent )


# https://www.youtube.com/watch?v=_lJ0jbahbjw
#==============================================================================
