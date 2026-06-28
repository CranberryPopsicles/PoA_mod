extends Node


class_name event_remove_buff

static func check(unit, buff, msg):
	
	if unit.Buffs.has(buff):
		unit.Buffs.erase(buff)
		effectmaker.create_effect_animated(unit.global_position, Global.EffectAnimated, "Purge")

	if unit == Global.Player:
		Global.game.get_node("UI").get_node("UI_BuffDrawer").write_buffs()
		
		var stringa = "你从自身[color=#c05050]移除[/color] " + buff.color + buff.name + "[/color]"
		if msg != "":
			stringa += "[color=#707070] <- " + textstrip.strip_bbcode(msg) + "[/color]"
		
		ToolMessageCreator.add_message("[color=#c0c0c0]", stringa)
	else:
		var stringa = unit.get_name_color() + " 从自身[color=#c05050]移除[/color] " + buff.color + buff.name + "[/color]"
		if msg != "":
			stringa += "[color=#707070] <- " + textstrip.strip_bbcode(msg) + "[/color]"
		
		ToolMessageCreator.add_message("[color=#c0c0c0]", stringa)
