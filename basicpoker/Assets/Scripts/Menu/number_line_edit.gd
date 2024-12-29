@tool 

class_name NumberLineEdit

extends LineEdit

func _ready() -> void:
	$".".text_changed.connect(process_incoming_text)

func process_incoming_text(new_text: String):
	if not new_text.is_valid_int():
		var invalid_text_end: int
		var invalid_text_lenght: int = 0
		for char in new_text:
			if not char.is_valid_int():
				invalid_text_lenght += 1
				invalid_text_end = new_text.find(char)
		$".".delete_text(invalid_text_end - invalid_text_lenght +1, invalid_text_end +1)
