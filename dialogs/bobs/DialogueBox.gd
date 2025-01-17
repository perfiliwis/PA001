extends CanvasLayer
class_name DialogueBox

signal dialogue_ended()

onready var dialogue_player : DialoguePlayer = $DialogueBox/DialoguePlayer
onready var text_label : = $DialogueBox/Panel/Text as RichTextLabel
onready var portrait : = $DialogueBox/Panel2/Portrait as TextureRect
onready var global_instance = get_node("/root/globalnote.gd")


var is_available = false # Inicialmente no disponible

func start(dialogue : Dictionary) -> void:
	"""
	Reinitializes the UI and asks the DialoguePlayer to 
	play the dialogue
	"""
	dialogue_player.start(dialogue)
	update_content()
	show()
	is_available = true # Marcar como disponible

# ...
# En DialogueBox.gd
func _process(_delta):
	#hide() # Oculta el cuadro de diálogo
	#emit_signal("dialogue_ended") # Emite la señal
	#is_available = true # Marcar como no disponible
	if Input.is_action_just_pressed("Enter"):
		var _index_current = 0
		if dialogue_player._index_current < dialogue_player._conversation.size():
			dialogue_player.next()
			update_content()
			global_instance._start_dialog()
		else:
			hide() # Oculta el cuadro de diálogo
			emit_signal("dialogue_ended") # Emite la señal
			is_available = true # Marcar como no disponible

# ...


func update_content() -> void:
	var dialogue_player_name = dialogue_player.title
	text_label.text = dialogue_player.text
	portrait.texture = DialogueDatabase.get_texture(dialogue_player_name, dialogue_player.expression)

	if is_available: # Mostrar si está disponible
		show()
	else: # Ocultar si no está disponible
		hide()



