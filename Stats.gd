extends Node
signal health_empty

@export var MAX_HEALTH = 1
@onready var health = MAX_HEALTH:
	set(val):
		health = val
		if health <= 0:
			health_empty.emit()



