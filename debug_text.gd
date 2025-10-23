extends RichTextLabel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Globals.register_debug_label(self)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func log(message: String) -> void:
	text += "\n" + message
	scroll_to_line(get_line_count()-1)
