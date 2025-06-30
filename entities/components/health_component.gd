class_name HealthComponent

extends Node

# health component deals with health and shield damage logic

# TODO work on death signal
signal died

var health : int
var shield : int

func _ready():
	shield = 0

func print_health():
	print("Health is ", health)

func get_health():
	return health

func equip_shield(strength):
	if (strength > 0):
		shield = strength

func receive_attack(atk, piercing):
	if (shield > 0):
		# TODO condense if else
		if (!piercing):
			shield -= atk
		else:
			shield -= atk
			if (shield <= 0):
				health += shield
	elif (shield < 0):
		health -= atk
	if (health < 0):
		print("char died")
		died.emit()

		
