class_name BaseTileMap
extends TileMap


#Code src: https://forum.godotengine.org/t/is-it-possible-to-get-tilemap-tiles-that-has-higher-y-sort-that-certain-position/39522/7
@export var player: Player
var wall_layer = 5
var player_coords: Vector2i
var cells_alpha = {}
func _tile_data_runtime_update(layer, coords, tile_data):
	tile_data.modulate.a = cells_alpha.get(coords, 1.0)
	
#Warning: Make sure this function only return true when needed. 
#Any tile processed at runtime without a need for it will imply a significant performance penalty.
func _use_tile_data_runtime_update(layer, coords):
	return cells_alpha.has(coords)

func _process(delta):
	player_coords = local_to_map(player.global_position)
	var coords = get_used_cells(wall_layer)
	for coord in coords:
		print("coord:{0}, player:{1}".format([coord.y, player_coords.y]))
		if coord.y == player_coords.y && coord.x == player_coords.x:
			if cells_alpha[coord] <= 0:
				cells_alpha[coord] = 0
			else:
				cells_alpha[coord] -= 0.1 * delta
		else:
			if cells_alpha[coord] >= 1:
				cells_alpha[coord] = 1.0
			else:
				cells_alpha[coord] += 0.1 * delta
		notify_runtime_tile_data_update(wall_layer)
