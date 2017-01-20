extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
onready var block = preload("../blocks/rock.tscn")
func _ready():
	print("Hello from world.")
	var y = 0
	for x in range(-10, 10):
		for z in range(-10, 10):
			#y = (randi() % 3) - 1
			var new = block.instance()
			new.translate(Vector3(x * 2,y*2,z*2))
			add_child(new)
