extends Node3D
@onready var text = $SubViewport/PhoneScreen/Control/TextNode

func _ready():
	# Clear the viewport.
	var viewport = $SubViewport
	$SubViewport.set_clear_mode(SubViewport.CLEAR_MODE_ONCE)

	# Retrieve the texture and set it to the viewport quad.
	$ViewportQuad.material_override.albedo_texture = viewport.get_texture()

func you_win():
	print("You Win")
	get_tree().quit()

func _process(delta):
	if not Global.is_driving:
		$SubViewport/PhoneScreen/TextEdit.text
		
func _unhandled_input(event):
	if event is InputEventKey and event.pressed == true:
		print(event)
		if event.pressed and event.keycode == KEY_ESCAPE:
			get_tree().quit()
			
			
		match(event.keycode):
			KEY_SPACE:
				text.label.text += " "
			KEY_BACKSPACE:
				print(text.label.text)
				text.label.text = text.label.text.substr(0, text.label.text.length() - 1)
			_:
				text.label.text += OS.get_keycode_string(event.key_label)
				
	if $SubViewport/PhoneScreen/Control/Label.text == $SubViewport/PhoneScreen/Control/TextNode.label.text:
		you_win()
