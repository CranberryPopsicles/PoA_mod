extends Node2D

var scene_disabled = false
var screenshotted = false
var body_labels = ["main", "off", "head", "chest", "leg", "hand"]

var more_info = false

func _ready():
	
	
	setup_deckbuttons()
	$Button2 / Label.bbcode_text = "[center]返回"
	$Button3 / Label.bbcode_text = "[center]统计"
	write_screen(Global.last_score_data)

func _process(_delta):
	pass
	
	
	
		
		
		
		
		
func write_screen(data):
	var stringa = "[color=#c0c0c0]"
	stringa += data.name
	stringa += "\n\n"
	

	
	match data.condition:
		"victory":
			stringa += "[color=#ff3000]胜利！[/color]"
		"death":
			stringa += "被 " + data.killer_name + " 杀死..."
			stringa += data.place_suffix + " " + data.place + "..."

		"abandon":
			stringa += "[color=#ff5050]放弃了道路...[/color]"

	stringa += "\n\n"
	stringa += "那是第 [color=#ffff00]" + str(data.day) + "[/color] 天"
	
	stringa += "\n\n"
	stringa += "位于 " + cycler.int_to_cycle_name(data.cycle)
	
	
	
	stringa += "\n\n"
	
	stringa += "[color=#ff8080]生命[/color] [color=#ffff00]" + str(int(data.life)) + "[/color]"
	stringa += "\n[color=#ff7050]力量[/color] [color=#ffff00]" + str(int(data.str)) + "[/color]"
	stringa += "\n[color=#50ff70]敏捷[/color] [color=#ffff00]" + str(int(data.dex)) + "[/color]"
	stringa += "\n[color=#c050ff]意志[/color] [color=#ffff00]" + str(int(data.wil)) + "[/color]"
	
	stringa += "\n\n[color=#707070]已装备[/color]"
	
	for item in data.inventory:
		stringa += "\n" + item.name
	
	stringa += "\n\n[color=#707070]已学习[/color]"
	
	for power in data.powers:
		stringa += "\n" + translate.trait_name(power) + " " + str(int(power.Level))
	
	stringa += "\n\n[color=#707070]事迹"
	
	for feat in data.feats:
		stringa += "\n" + feat
		
			
			
		
	
	$RichTextLabel.bbcode_text = stringa
	
	
	
	
	
	
	
	
	
		
	
	
		
	
	
	
	
	
	
	
	
	
	
	stringa = "[right]"
	
	stringa += ""
	
	
	
	var enemies = []
	
	for title in data.enemies:
		enemies.append(LEnemies.enemy_data[title])
	
	for enemy in enemies:
		if enemy.boss == true:
			stringa += "[img]" + enemy.sprite + "[/img]"
			
	stringa += "\n"
	for enemy in enemies:
		if enemy.boss == false:
			stringa += "[img]" + enemy.sprite + "[/img]"
	
	stringa += ""
	if data.has("preta"):
		for sprite in data.preta:
			stringa += "[img]" + sprite + "[/img]"
	
	var allies = []
	if allies.size():
		stringa += "\n"
	
	for title in data.allies:
		allies.append(LAllies.ally_data[title])
	for ally in allies:
		stringa += "[img]" + ally.sprite + "[/img]"
	
	
	
	$enemies.bbcode_text = stringa
	
	stringa = "[center]"
	
	stringa += "[/center]"
	$allies.bbcode_text = stringa
	
	$Control.get_node("body").texture = load(data.body)
	for label in body_labels:
			draw_body_element(data, label)
	
	write_middle(data)
	
func write_middle(data):
	
	if more_info == false:
		var stringa = "[center][color=#a0a0a0]"
		stringa += "本次道路持续了 [color=#ff5050]" + str(data.game_turns) + "[/color] 个游戏回合"
		stringa += "\n\n"
		stringa += "攻击 [color=#ffff00]" + translate.add_commas(str(data.times_attack)) + "[/color] 次"
		stringa += "\n"
		stringa += "站立不动 [color=#ffff00]" + translate.add_commas(str(data.times_stood)) + "[/color] 次"
		stringa += "\n"
		stringa += "祈祷 [color=#ffff00]" + translate.add_commas(str(data.times_pray)) + "[/color] 次"
		stringa += "\n"
		stringa += "神圣干预 [color=#ffff00]" + translate.add_commas(str(data.times_intervention)) + "[/color] 次"
		stringa += "\n\n"
		stringa += "总伤害 [color=#ffff00]" + translate.add_commas(str(data.damage_dealt)) + "[/color]"
		stringa += "\n"
		stringa += "最高伤害 [color=#ffff00]" + translate.add_commas(str(data.highest_damage)) + "[/color]"
		if str(data.highest_damage_type) != "0":
				stringa += " " + translate.damage_type(data.highest_damage_type)
		stringa += "\n"
		stringa += "承受伤害 [color=#ffff00]" + translate.add_commas(str(data.damage_taken)) + "[/color]"
		stringa += "\n"
		stringa += "治疗量 [color=#ffff00]" + translate.add_commas(str(data.amount_healed)) + "[/color]"
		stringa += "\n\n"
		stringa += "击杀敌人 [color=#ffff00]" + translate.add_commas(str(data.enemies_killed)) + "[/color]"
		stringa += "\n"
		stringa += "召唤盟友 [color=#ffff00]" + translate.add_commas(str(data.allies_summoned)) + "[/color]"
		stringa += "\n"
		stringa += "盟友击杀 [color=#ffff00]" + translate.add_commas(str(data.enemies_killed_by_allies)) + "[/color]"
		$poem.bbcode_text = stringa
	
	
	else:
		pass
		var stringa = "[center][color=#a0a0a0]"
		stringa += "[color=#ff5050]" + str(data.game_turns) + "[/color] 个游戏回合已过去"
		stringa += "\n\n"
		stringa += "进行了 [color=#ffff00]" + translate.add_commas(str(data.times_attack)) + "[/color] 次攻击"
		stringa += "\n"
		stringa += "站立不动 [color=#ffff00]" + translate.add_commas(str(data.times_stood)) + "[/color] 次"
		stringa += "\n"
		stringa += "祈祷 [color=#ffff00]" + translate.add_commas(str(data.times_pray)) + "[/color] 次"
		stringa += "\n"
		stringa += "获得 [color=#ffff00]" + translate.add_commas(str(data.times_intervention)) + "[/color] 次神圣干预"
		
		stringa += "\n\n"
		stringa += "造成 [color=#ffff00]" + translate.add_commas(str(data.damage_dealt)) + "[/color] 总伤害"
		stringa += "\n"
		stringa += "最高伤害为 [color=#ffff00]" + translate.add_commas(str(data.highest_damage)) + "[/color]"
		if str(data.highest_damage_type) != "0":
				stringa += " " + translate.damage_type(data.highest_damage_type)
		stringa += "\n"
		stringa += "承受 [color=#ffff00]" + translate.add_commas(str(data.damage_taken)) + "[/color] 总伤害"
		stringa += "\n"
		stringa += "获得 [color=#ffff00]" + translate.add_commas(str(data.amount_healed)) + "[/color] 总治疗量"
		
		stringa += "\n\n"
		if data.highest_stack_effect > 0:
			stringa += "最高已施加效果 [color=#ffff00]" + translate.add_commas(str(data.highest_stack_effect)) + "[/color] " + str(data.highest_stack_effect_label)
		else:
			stringa += "[color=#ff5050]没有施加效果[/color]"
		
		
		stringa += "\n\n"
		stringa += "击杀 [color=#ffff00]" + translate.add_commas(str(data.enemies_killed)) + "[/color] 个敌人"
		
		stringa += "\n\n"
		stringa += "召唤 [color=#ffff00]" + translate.add_commas(str(data.allies_summoned)) + "[/color] 名盟友"
		stringa += "\n"
		stringa += "[color=#ffff00]" + translate.add_commas(str(data.enemies_killed_by_allies)) + "[/color] 个敌人被盟友击杀"
		stringa += "\n"
		stringa += "击杀 [color=#ffff00]" + translate.add_commas(str(data.allies_killed)) + "[/color] 名盟友"
		
		$poem.bbcode_text = stringa

	
	
	
	



func draw_body_element(data, label):
	if data[label] != "none":
		$Control.get_node(label).texture = load(data[label])
	else:
		$Control.get_node(label).texture = null
			
func remove_unit_duplicates(data):
	var to_erase = []
	var cleaned_array = []
	for unit in data:
		cleaned_array.append(unit)
		var label = unit.name
		var count = 0
		for unit2 in data:
			if unit2.name == label:
				count += 1
			if count > 1:
				if to_erase.has(unit2) == false:
					to_erase.append(unit2)
	for unit in to_erase:
		cleaned_array.erase(unit)
	
	return cleaned_array
	
			

func quit():
	scene_disabled = true
	Global.universal.transition("start")


func _on_Button2_mouse_entered():
	Global.sound.new_sound("Hover")


func _on_Button2_pressed():
	quit()

func _input(event):
	if scene_disabled == false:
		if event.is_action_pressed("enter") or event.is_action_pressed("escape"):
			quit()
		Global.universal.deck.input_handler(event)
		
func setup_deckbuttons():
	if Global.universal.deck.allowed == true:
		Global.universal.deck.deckbuttons = [[$Button2, $Button3]]
		Global.universal.deck.index_x = 0
		Global.universal.deck.index_y = 0
		Global.universal.deck.set_first_button()


func _on_Button3_mouse_exited():
	Global.sound.new_sound("Hover")
	more_info = false
	write_middle(Global.last_score_data)


func _on_Button3_mouse_entered():
	Global.sound.new_sound("Hover")
	more_info = true
	write_middle(Global.last_score_data)
