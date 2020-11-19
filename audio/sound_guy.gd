extends Node

# placeholder dummy variable to keep Global.instance_node() happy
export var global_position:Vector2 = Vector2(0,0)

func _ready():
	Global.node_sound_guy = self

func _exit_tree():
	Global.node_sound_guy = null

