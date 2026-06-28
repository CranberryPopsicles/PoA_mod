extends Node


class_name event_levelup

static func check(unit):
	var traits = unit.get_traits()
	
	if traits.has("Nihang"):
		
		
		var item = null
		if Global.Player.weapon_main != null:
					item = Global.Player.weapon_main
		elif Global.Player.weapon_off != null:
					item = Global.Player.weapon_off
		if item != null:
			item.dmg += 2
			var stringa = ""
			stringa += item.name
			stringa = "你强化了你的 " + stringa + " [color=#ff8030]+20 命中[/color]"
			stringa += " [color=#707070]提升至 " + str(item.dmg * 10)
			ToolMessageCreator.add_message("[color=#c0c0c0]", stringa)
			if "Abdi" in item.name:
						pass
			else:
				item.name = "[color=#a08080]Abdi-blessed[/color] " + item.name

	if traits.has("Anroth"):
		if unit.ELEMENTS == []:
			var items = [unit.weapon_main, unit.weapon_off]
			for item in items:
				if item != null:
					item.dmg += 10
					item.arm += 100
					var stringa = ""
					stringa += item.name
					stringa = "你强化了你的 " + stringa + " [color=#ff8030]+100 命中[/color] / [color=#5050ff]+100 格挡[/color]"
					stringa += " [color=#707070]提升至 " + str(item.dmg * 10) + " 命中 / " + str(item.arm) + " 格挡[/color]"
					ToolMessageCreator.add_message("[color=#c0c0c0]", stringa)
					if "Anroth" in item.name:
						pass
					else:
						item.name = "[color=#309fbf]Anrothic[/color] " + item.name
			var action = {
			"name": "heal", 
			"amount": unit.HP_max - unit.HP, 
			"healer_unit": unit, 
			"healed_unit": unit, 
			"msg": "Anroth"
		}
			ProcessQueue.add_effect(action)
			for buff in unit.Buffs:
				if buff.source != buff.target:
				
					action = {
					"name": "remove_buff", 
					"target": unit, 
					"buff": buff, 
					"msg": "Anroth"
		}
					ProcessQueue.add_effect(action)
