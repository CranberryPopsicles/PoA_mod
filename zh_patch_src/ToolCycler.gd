extends Node


class_name cycler





static func unlock_next_cycle():
	var risen = false
	var max_cycle = 32
	
	if ToolSettings.settings_data.cycle_unlocked < max_cycle:
		if int(ToolSettings.settings_data.cycle_unlocked) == int(ToolSettings.settings_data.cycle_current):
			ToolSettings.settings_data.cycle_unlocked += 1
			ToolSettings.settings_data.cycle_current = ToolSettings.settings_data.cycle_unlocked
			risen = true
	
	
		
	
		
	ToolSettings.save_settings()
	return risen

static func toggle_current_cycle():
	if ToolSettings.settings_data.cycle_current < ToolSettings.settings_data.cycle_unlocked:
		ToolSettings.settings_data.cycle_current += 1
	else:
			ToolSettings.settings_data.cycle_current = 1

static func toggle_current_cycle_down():
	if ToolSettings.settings_data.cycle_current > 1:
		ToolSettings.settings_data.cycle_current -= 1
	else:
			ToolSettings.settings_data.cycle_current = ToolSettings.settings_data.cycle_unlocked

static func int_to_cycle_name(inta):
	var stringa = ""
	inta = int(inta)
	
	match inta:
		1:
			stringa += "[color=#c09050]第一[/color]轮回：[color=#c09050]谦卑[/color]"
		2:
			stringa += "[color=#9050c0]第二[/color]轮回：[color=#9050c0]堕落[/color]"
		3:
			stringa += "[color=#50b050]第三[/color]轮回：[color=#50b050]希望[/color]"
		4:
			stringa += "[color=#b03090]第四[/color]轮回：[color=#b03090]绝望[/color]"
		5:
			stringa += "[color=#3030e0]第五[/color]轮回：[color=#3030e0]启明[/color]"
		6:
			stringa += "[color=#a02020]第六[/color]轮回：[color=#a02020]湮灭[/color]"
		7:
			stringa += "[color=#f06030]第七[/color]轮回：[color=#f06030]天启[/color]"
		8:
			stringa += "[color=#f03090]第八[/color]轮回：[color=#f03090]激情[/color]"
		9:
			stringa += "[color=#2020a0]第九[/color]轮回：[color=#2020a0]瓦解[/color]"
		10:
			stringa += "[color=#408040]第十[/color]轮回：[color=#408040]吞噬[/color]"
		11:
			stringa += "[color=#908060]第十一[/color]轮回：[color=#908060]启示[/color]"
		12:
			stringa += "[color=#ffaf20]第十二[/color]轮回：[color=#ffaf20]荣耀[/color]"
		13:
			stringa += "[color=#8f208f]第十三[color=#c0c0c0]轮回：[/color]执念[/color]"
		14:
			stringa += "[color=#ff806f]第十四[color=#c0c0c0]轮回：[/color]孤绝[/color]"
		15:
			stringa += "[color=#af606f]第十五[color=#c0c0c0]轮回：[/color]傲慢[/color]"
		16:
			stringa += "[color=#ff303f]第十六[color=#c0c0c0]轮回：[/color]破裂[/color]"
		17:
			stringa += "[color=#9f903f]第十七[color=#c0c0c0]轮回：[/color]剥蚀[/color]"
		18:
			stringa += "[color=#3f307f]第十八[color=#c0c0c0]轮回：[/color]省略[/color]"
		19:
			stringa += "[color=#3f907f]第十九[color=#c0c0c0]轮回：[/color]孕生[/color]"
		20:
			stringa += "[color=#3fd09f]第二十[color=#c0c0c0]轮回：[/color]显赫[/color]"
		21:
			stringa += "[color=#dfa0ff]第二十一[color=#c0c0c0]轮回：[/color]冷漠[/color]"
		22:
			stringa += "[color=#afa00f]第二十二[color=#c0c0c0]轮回：[/color]怨恨[/color]"
		23:
			stringa += "[color=#ff300f]第二十三[color=#c0c0c0]轮回：[/color]屠戮[/color]"
		24:
			stringa += "[color=#6fff00]第二十四[color=#c0c0c0]轮回：[/color]神性[/color]"
		25:
			stringa += "[color=#A0522D]第二十五[color=#c0c0c0]轮回：[/color]严酷修正[/color]"
		26:
			stringa += "[color=#DA70D6]第二十六[color=#c0c0c0]轮回：[/color]破碎法则[/color]"
		27:
			stringa += "[color=#00BFFF]第二十七[color=#c0c0c0]轮回：[/color]宇宙怒火[/color]"
		28:
			stringa += "[color=#DC143C]第二十八[color=#c0c0c0]轮回：[/color]膨胀恐惧[/color]"
		29:
			stringa += "[color=#B0E0E6]第二十九[color=#c0c0c0]轮回：[/color]扭曲之光[/color]"
		30:
			stringa += "[color=#4169E1]第三十[color=#c0c0c0]轮回：[/color]沉没世界[/color]"
		31:
			stringa += "[color=#00FA9A]第三十一[color=#c0c0c0]轮回：[/color]破碎高塔[/color]"
		32:
			stringa += "[color=#8A2BE2]第三十二[color=#c0c0c0]轮回：[/color]外侧黑暗[/color]"
	
	return stringa

static func get_multi():
	var multi = 0
	multi = int(ToolSettings.settings_data.cycle_current)
	if multi >= 6:
		multi += (multi / 2)
	if multi > 24:
		multi += (multi / 2)
	if multi >= 30:
		multi += (multi / 2)
	if StateWorld.land == "dust":
		multi = StateWorld.Floor_Current * StateWorld.Floor_Current
	
		
	return multi

static func apply_cycle_bonus(unit, list):
	
	var rng = Global.rng
	var multi = get_multi()
	
	
	
	
		
	
	var multi_min = 0
	if float(multi) / 2.0 > 0.0:
		multi_min = int(float(multi) / 2.0)
	
	var allowed = false
	if multi > 1 and StateWorld.day > 0:
		allowed = true
	if StateWorld.land == "dust":
		allowed = true
	
	if allowed == true:
		
		unit.cycle_boosted = true
		
		if list.has("hit") == false:
			var new_multi = rng.randi_range(multi_min, multi)
			new_multi /= 2
			if new_multi < 1:
				new_multi = 1
			var damage_increase = unit.damage * new_multi
			if damage_increase > 100.0:
				damage_increase = 100.0 + (new_multi * 5.0)
			if new_multi > 0:
				var action = {
				"name": "apply_bonus", 
				"origin": unit, 
				"target": unit, 
				"amount": damage_increase, 
				"type": "damage", 
				"msg": "Amplification"
				}
				unit.get_node("AnimationPlayer2").play("cycle")
				ProcessQueue.add_effect(action)
		
		for attribute in list:
			var new_multi = rng.randi_range(multi_min, multi)
			if new_multi > 0:
				var action = {
				"name": "apply_bonus", 
				"origin": unit, 
				"target": unit, 
				"amount": 0.0, 
				"type": "none", 
				"msg": "Amplification"
				}
			
				match attribute:
					"hp":
						var new_hp = unit.HP_max * new_multi
						if unit.type.boss == false:
							if new_hp > ToolSettings.settings_data.cycle_current * 1000.0:
								new_hp = (ToolSettings.settings_data.cycle_current * 1000.0) + (200.0 * new_multi)
						action.amount = new_hp
						action.type = "life"
					"armor":
						action.amount = unit.ARM * new_multi
						action.type = "armor"
					"accuracy":
						action.amount = unit.accuracy * new_multi
						action.type = "accuracy"
					"hit":
						unit.get_node("AnimationPlayer2").play("cycle")
						var damage_increase = unit.damage * new_multi
						if damage_increase > 100.0:
							damage_increase = 100.0 + (new_multi * 5.0)
						action.amount = damage_increase
						action.type = "damage"
					"block":
						action.amount = unit.deflect_strength * new_multi
						action.type = "block"
					"speed":
						action.amount = unit.speed * new_multi
						action.type = "speed"
					"dodge":
						action.amount = unit.dodge * new_multi
						action.type = "dodge"
				
				
			
			

				ProcessQueue.add_effect(action)

static func write_amplification(type):
	
	if type.has("cycle"):
	
		var stringa = ""
	
		for string in type.cycle:
			stringa += "\n"
		
			match string:
				"hit":
					stringa += "     [color=#ff8030]+ 命中[/color]"
				"accuracy":
					stringa += "     [color=#ffa050]+ 精准[/color]"
				"dodge":
					stringa += "     [color=#50ffff]+ 闪避[/color]"
				"block":
					stringa += "     [color=#5050ff]+ 格挡[/color]"
				"armor":
					stringa += "     [color=#5050ff]+ 护甲[/color]"
				"speed":
					stringa += "     [color=#20ff20]+ 速度[/color]"
				"hp":
					stringa += "     [color=#ff8080]+ 最大生命[/color]"
	
		return stringa

static func glory_bonus(glory):
	var rng = Global.rng
	var multi = get_multi()
	var multi_min = 1.0
	
	if ToolSettings.settings_data.cycle_current > 24:
		multi = 24 + (int(ToolSettings.settings_data.cycle_current) / 2)

	
	if StatePlayerSheet.level >= Global.cycle_taper:
		multi = ToolSettings.settings_data.cycle_current / 3
		if multi < 1: multi = 1
	

	multi_min = int(multi_min)
	
	if StateWorld.land == "dust":
		if StateWorld.Floor_Current > 1:
			multi = StateWorld.Floor_Current / 2
		else:
			multi = 1
	
	if multi > 1:
		multi = rng.randi_range(multi_min, multi)
		glory *= multi
		print("glory multiplied")
	
	return glory
