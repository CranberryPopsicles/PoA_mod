extends CanvasLayer


var type = "none"
var data = null

onready var sprite_a = $UiBoxSideways / Content / Sprite
onready var label_a = $UiBoxSideways / Content / Label


func create_display():
	ProcessQueueNongame.open_popups.append(get_node("."))
	
	match type:
		
		"unlock":
			Global.sound.new_sound("Invoke")
			sprite_a.texture = load(data.icon)
			label_a.bbcode_text = data.name + " 已解锁！"
			label_a.bbcode_text += "\n\n[color=#a070a0]" + data.brief + "[/color]"
		
		
		"glory":
			sprite_a.texture = null
			label_a.bbcode_text = str(data.glory) + " / " + str(data.glory_needed)
			pass


func press_A():
	
	ProcessQueueNongame.open_popups.erase(get_node("."))
	queue_free()

func _input(event):
	if event.is_action_pressed("tab") or event.is_action_pressed("enter") or event.is_action_pressed("click"):
		press_A()
	if event.is_action_pressed("pass"):
		press_A()
	if event.is_action_pressed("up"):
		press_A()
	if event.is_action_pressed("upleft"):
		press_A()
	if event.is_action_pressed("upright"):
		press_A()
	if event.is_action_pressed("left"):
		press_A()
	if event.is_action_pressed("right"):
		press_A()
	if event.is_action_pressed("down"):
		press_A()
	if event.is_action_pressed("downleft"):
		press_A()
	if event.is_action_pressed("downright"):
		press_A()
	if event.is_action_pressed("gamepad_a"):
		press_A()

func _on_ButtonA_pressed():
	press_A()
	


func _on_ButtonA_mouse_entered():
	Global.sound.new_sound("Hover")
