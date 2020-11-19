extends Node2D

const CENTER_OF_SCREEN = Vector2(640, 360)

var db = true                      # debug msgs on off
var enemy_square      = preload("res://Enemy/Enemy.tscn")
var enemy_patrol_mine = preload("res://Enemy/patrol.tscn")
var sound_guy         = preload("res://audio/sound_guy.tscn")

#------------------------------------------------------------------------------
func _ready():
	# define this node (self) as the 'root' node, 
	# so other nodes instance in this scene using 'Global.instance_node()'
	Global.node_creation_parent = self

	# Instance a node (sound_guy.tscn) as a child of Arena
	Global.instance_node(sound_guy, Vector2(0,0), self)
#	Global.instance_node(enemy_patrol_mine, Vector2(0,0), self)
	
	#http://kidscancode.org/godot_recipes/input/mouse_capture/
	Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)
	
	if db: print("Viewport size in pixels ", str( get_viewport().size ) )

#------------------------------------------------------------------------------
func _exit_tree():
	Global.node_creation_parent = null
	
#------------------------------------------------------------------------------
func _process(delta):
	$Label.text = ("Health " + str(Global.g_player_hp) + "  Misses : " + str(Global.g_bulletmiscount) + "  Enemies: " + str(Global.g_enemycount) )
	
	if ( Input.is_action_pressed("ui_cancel") ):          # 'esc' key exits game
		get_tree().quit()
	
	update()     # draw lines in _draw()
#------------------------------------------------------------------------------
# spawn an enemy in the field
func _on_Timer_spawnEnemy_timeout():
	if   Global.g_enemycount > 20:
		$Timer_spawnEnemy.wait_time = 6
	elif Global.g_enemycount > 10:
		$Timer_spawnEnemy.wait_time = 4
	elif Global.g_enemycount > 5:
		$Timer_spawnEnemy.wait_time = 2
	else                        :
		$Timer_spawnEnemy.wait_time = 1
		
	Global.instance_node(enemy_square, spawn_location(), self)
#------------------------------------------------------------------------------
# gives a random location for an enemy to spawn
func spawn_location() -> Vector2:
	var phi = rand_range(0, 2*PI)
	var loc:Vector2 = ( CENTER_OF_SCREEN.length() * Vector2(cos(phi), sin(phi)) )
	loc += CENTER_OF_SCREEN
	if db: print("Spawn at: ", str(loc))
	return (loc)

#------------------------------------------------------------------------------
# draw a line from the player to help aim.
func _draw():
	var linefrom = $Player.global_position
	var lineto   = get_global_mouse_position()
	draw_line(linefrom, lineto, Color(0.2, 0.0, 0.0) ,0.1 , false)
	
#==============================================================================
