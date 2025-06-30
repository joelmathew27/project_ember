extends TileMapLayer

# when mouse hover, change tile to atlas coords (0, 1) 
# and when left cell, change back to previous tile

var previousTile = Vector2i(0, 0)
var previousTileID = Vector2i(1, 1)
const TILE_SOURCE_ID = 0

func _input(event):
	if event is InputEventMouseMotion:
		var mouse_pos = get_global_mouse_position()
		var tile_pos = local_to_map(mouse_pos)
		if (has_tile(mouse_pos)) && tile_pos != previousTile:
			set_cell(previousTile, TILE_SOURCE_ID, previousTileID)
			previousTile = tile_pos
			previousTileID = get_cell_atlas_coords(tile_pos)
			set_cell(tile_pos , 0, Vector2i(0, 1))


func has_tile(pos):
	if get_cell_source_id(pos) != -1:
		#print(get_cell_source_id(pos), " - source id")
		#print(get_cell_atlas_coords(pos), " - atlas id")
		return true
	else:
		#print(get_cell_source_id(pos), " - source id")
		#print(get_cell_atlas_coords(pos), " - atlas id")
		return true

func snap_to_grid(char_pos):
	var cell = local_to_map(char_pos)
	var temp_position = map_to_local(cell)
	# temp_position.x += rendering_quadrant_size
	# temp_position.y += rendering_quadrant_size
	return temp_position 
