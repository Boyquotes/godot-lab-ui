extends Label

## VARS
var DEBUG = true

export var destination: String

onready var animation_player = $AnimationPlayer

enum {
	OVER,
	OUT,
	IN
}

## FUNCS
func enter_state(new_state):
	match new_state:
		OVER:
			animation_player.play("over")

		OUT:
			set_modulate(Color.white)
			animation_player.stop()
		IN:
			if DEBUG:
				print("[dbg] Going to %s.")
			if destination == "quit":
				get_tree().quit()
			else:
				get_tree().change_scene(destination)

func process_input():
	if Input.is_action_just_pressed("ui_accept"):
		print("Modulate: ", modulate)

## SIGNALS
func _on_mouse_entered():
	enter_state(OVER)

func _on_mouse_exited():
	enter_state(OUT)

func _on_gui_input(event):
	if event is InputEventMouseButton and not event.is_pressed():
		enter_state(IN)

## EXECUTION
func _ready():
	connect("mouse_entered", self, "_on_mouse_entered")
	connect("mouse_exited", self, "_on_mouse_exited")
	connect("gui_input", self, "_on_gui_input")

func _process(delta):
	process_input()
