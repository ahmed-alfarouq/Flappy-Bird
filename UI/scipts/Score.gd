extends CanvasLayer

@onready var main = get_node("/root/Main")

func _process(_delta):
	if (main.isStarted && !visible):
		visible = true
	
	if (main.isDead && visible):
		visible = false
