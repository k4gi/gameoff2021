extends TextureButton


signal pressed_me(me)


func ready():
	connect("pressed", self, "on_pressed")


func on_pressed():
	print("pressed")
	emit_signal("pressed_me", self)
