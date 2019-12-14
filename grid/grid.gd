extends TileMap

enum { EMPTY = -1, ACTOR, OBSTACLE, OBJECT}

func _ready():
	for child in get_children():
		print(child.name)
		if (not "TextureRect" in child.name) and (not "obstacle" in child.name):
			set_cellv(world_to_map(child.position), child.type)
		
func get_cell_pawn(coordinates):
	for node in get_children():
		if world_to_map(node.position) == coordinates:
			return(node)

func request_move(pawn, direction):
	var cell_start = world_to_map(pawn.position)
	var cell_target = cell_start + direction
	
	var cell_target_type = get_cellv(cell_target)
	match cell_target_type:
		EMPTY:
			return update_pawn_position(pawn, cell_start, cell_target)
		OBJECT:
			var object_pawn = get_cell_pawn(cell_target)
			object_pawn.queue_free()
			return update_pawn_position(pawn, cell_start, cell_target)
		ACTOR:
			var pawn_name = get_cell_pawn(cell_target).name
			print("Cell %s contains %s" % [cell_target, pawn_name])

func update_pawn_position(pawn, cell_start, cell_target):
	set_cellv(cell_target, pawn.type)
	set_cellv(cell_start, EMPTY)
	return map_to_world(cell_target) + cell_size / 2
	
func move_with_direction(input_direction):
	var actor = get_node("/root/Game/Grid/Actor")
	actor.update_look_direction(input_direction)
	var target_position = self.request_move(actor, input_direction)
	if target_position:
		actor.move_to(target_position)
	else:
		actor.bump()	
