extends Node

var debug_text: RichTextLabel = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func register_debug_label(label: RichTextLabel) -> void:
	debug_text = label

func log(message: Variant) -> void:
	if debug_text:
		debug_text.log(str(message))
	else:
		push_warning("Debug label not added yet!")
