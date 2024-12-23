extends OptionButton

@export var font: Font
@export var font_size: float
@export var panel_style_box: StyleBox
@export var hover_style_box: StyleBox
@export var pressed_style_box: StyleBox

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var popup = get_popup()
	
	popup.add_theme_font_override("font", font)
	popup.add_theme_font_size_override("font_size", font_size)
	
	popup.add_theme_stylebox_override("panel", panel_style_box)
	popup.add_theme_stylebox_override("hover", hover_style_box)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
