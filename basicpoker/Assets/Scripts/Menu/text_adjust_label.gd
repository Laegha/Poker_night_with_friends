extends Label

@export var min_text_to_fill_scale: float
@export var min_font_size: int
func text_changed():
	#print(is_text_clipped())
	var font_size =  get_theme_font_size("font_size")
	while is_text_clipped(font_size):
		font_size -= 16
		add_theme_font_size_override("font_size", font_size)
	
func _ready() -> void:
	text_changed()

func is_text_clipped(font_size) -> bool:
	var label_width = size.x
	var text_width = get_theme_font("font").get_string_size(text).x * min_text_to_fill_scale * font_size / min_font_size
	return text_width > label_width
