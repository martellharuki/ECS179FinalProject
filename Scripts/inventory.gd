extends CanvasLayer

const STORAGE_SLOTS = 8  
const CRAFTING_SLOTS = 4  

@onready var inventory_panel = $InventoryPanel
@onready var storage_grid = $InventoryPanel/MarginContainer/MainContainer/StorageContainer/StorageGrid
@onready var crafting_grid = $InventoryPanel/MarginContainer/MainContainer/CraftingContainer/CraftingGrid
@onready var craft_button = $InventoryPanel/MarginContainer/MainContainer/CraftingContainer/CraftButton
@onready var result_slot = $InventoryPanel/MarginContainer/MainContainer/CraftingContainer/ResultSlot

var storage_items = []
var crafting_items = []
var is_inventory_open = false

func _ready():
	setup_ui()
	inventory_panel.visible = false
	
	# Initialize arrays
	for i in range(STORAGE_SLOTS):
		storage_items.append(null)
	for i in range(CRAFTING_SLOTS):
		crafting_items.append(null)	
		
		
func _input(event):
	var pause_screen = get_parent().get_node_or_null("PauseScreen")
	
	# Don't let inventory to open if pause screen is visible
	if pause_screen != null and pause_screen.visible:
		return
	
	if event.is_action_pressed("inventory"): 
		toggle_inventory()		
		

func setup_ui():
	# storage slots, a 2x2 grid
	for i in range(STORAGE_SLOTS):
		var slot = create_slot()
		storage_grid.add_child(slot)
	
	# crafting slots a 2x2 grid
	for i in range(CRAFTING_SLOTS):
		var slot = create_slot()
		crafting_grid.add_child(slot)
	
func create_slot() -> Panel:
	var slot = Panel.new()
	slot.custom_minimum_size = Vector2(80, 80)
	
	var style = StyleBoxFlat.new()
	style.bg_color = Color(0.15, 0.15, 0.18, 0.95)
	style.border_width_left = 2
	style.border_width_right = 2
	style.border_width_top = 2
	style.border_width_bottom = 2
	style.border_color = Color(0.25, 0.25, 0.28)
	style.corner_radius_top_left = 6
	style.corner_radius_top_right = 6
	style.corner_radius_bottom_left = 6
	style.corner_radius_bottom_right = 6
	slot.add_theme_stylebox_override("panel", style)
	
	var item_display = ColorRect.new()
	item_display.name = "ItemDisplay"
	item_display.custom_minimum_size = Vector2(50, 50)
	item_display.anchor_left = 0.5
	item_display.anchor_top = 0.5
	item_display.anchor_right = 0.5
	item_display.anchor_bottom = 0.5
	item_display.offset_left = -25
	item_display.offset_top = -25
	item_display.offset_right = 25
	item_display.offset_bottom = 25
	item_display.visible = false
	slot.add_child(item_display)
	
	var label = Label.new()
	label.name = "ItemLabel"
	label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	label.anchor_right = 1
	label.anchor_bottom = 1
	label.add_theme_color_override("font_color", Color(0.7, 0.7, 0.75))
	label.add_theme_font_size_override("font_size", 11)
	slot.add_child(label)
	
	return slot

func toggle_inventory():
	is_inventory_open = !is_inventory_open
	inventory_panel.visible = is_inventory_open
	
	if is_inventory_open:
		get_tree().paused = true
	else:
		get_tree().paused = false
	
