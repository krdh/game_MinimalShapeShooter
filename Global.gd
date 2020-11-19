extends Node
# singletons , every node can access this
# [project]-project settings-> autoload-> path set to 'Global.gd' -> Add

var node_creation_parent = null
var node_player          = null
var node_sound_guy       = null

var g_bulletcount:int
var g_bullethitcount:int
var g_bulletmiscount:int
var g_enemycount:int
var g_player_hp:int

#------------------------------------------------------------------------------
# https://www.youtube.com/watch?v=6e9I_e8aHD4
# usage example: var bullet = instance_node( bullet_instance, global_position, get_parent() )
func instance_node(node, location, parent ):
	var node_instance = node.instance()
	parent.add_child(node_instance)
	if location is Vector2:
		node_instance.global_position = location
	return node_instance
#------------------------------------------------------------------------------

func playsound(sound):
	if node_sound_guy != null :
		if node_sound_guy.has_node(sound):
			node_sound_guy.get_node(sound).play()
			print("playing sound")
#example Global.playsound("Shoot")
#example Global.playsound("Hit")
#------------------------------------------------------------------------------
