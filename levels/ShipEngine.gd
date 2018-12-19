extends Node2D

# 2019-01-05 acodemia.pl

const SPEED = 100
var offset = 0

func _ready():
	set_process(true)
	pass

func _process(delta):
	offset += delta * SPEED
	position.y -= delta * SPEED
	pass
