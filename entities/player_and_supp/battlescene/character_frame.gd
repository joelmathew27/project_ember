extends Node2D

@export var floorTiles : TileMapLayer



func _ready():
	print("Character frame ready")
	print("Position before snap: ", position)
	print("Global position before snap: ", global_position)
	# Call the function to snap the position to the grid
	fix_location()
	print("Position after snap: ", position)
	print("Global position after snap: ", global_position)
	print(floorTiles)

func fix_location():
	position = floorTiles.snap_to_grid(position)
