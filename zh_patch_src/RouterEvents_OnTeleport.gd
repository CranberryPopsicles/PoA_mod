extends Node

class_name event_teleport

static func check(unit, tile_target, msg):
	if unit.get_buff_names().has("Stasis") == false or unit.get_traits().has("Starjumper") == true:
		effectmaker.create_effect_animated(unit.global_position, Global.EffectAnimated, "Summon")
		
		if unit == Global.Player:
			ToolInvokes.recharge("teleport")
		
		
		
		var buff = cloner.clone_dict(LBuffs.buff_data.Stasis)
		buff["target"] = unit
		buff["source"] = unit
		var actionbuff = {
				"name": "add_buff", 
				"buff": buff, 
				"msg": "传送中"
			}
		ProcessQueue.add_effect(actionbuff)
		
		if tile_target != null:
			if tile_target.resident == null:
				unit.residence.resident = null
				tile_target.resident = unit
				unit.residence = tile_target
				unit.position = tile_target.position
				unit.get_node("Tween").stop_all()
				effectmaker.create_effect_animated(tile_target.global_position, Global.EffectAnimated, "Summon")
		
		text_popup(unit)
		ToolMessageCreator.add_message("[color=#c0c0c0]", message_teleport(unit, msg))
	
	
		var unit_traits = unit.get_traits()
	
		
	
		if unit.get_traits().has("Shimmergang"):
			for n in unit.get_traits().Shimmergang.Level * 1:
				var action = {
					"name": "summon", 
					"alliance": "ally", 
					"type": LAllies.ally_data.Blinksnake, 
					"summoner": unit, 
					"msg": unit_traits.Shimmergang.Name
				}
				ProcessQueue.add_effect(action)
		
		if unit.get_traits().has("Qamar"):
			var damage = 100.0
			var multi = 1
			if unit == Global.Player:
				multi = 4 - Global.Player.get_armor_list().size()
			
			for n in multi:
				var action = {
			"name": "magic_damage_tiles_in_path_to_targets_in_range", 
			"caster": unit, 
			"damage": damage, 
			"damage_type": "astral", 
			"effect_sprite": "Astral", 
			"number_of_targets": 1, 
			"effect_range": 3, 
			"enemies": null, 
			"msg": unit_traits.Qamar.Name
				}
				ProcessQueue.add_effect(action)

		if Global.Player.get_traits().has("CosmicDiscplate"):
			var med_buff = cloner.clone_dict(LBuffs.buff_data.Meditate)
			med_buff["target"] = Global.Player
			med_buff["source"] = Global.Player
			med_buff.duration = 5
			var action = {
			"name": "add_buff", 
			"buff": med_buff, 
			"msg": Global.Player.get_traits().CosmicDiscplate.Name
			}
			ProcessQueue.add_effect(action)
			
			med_buff = cloner.clone_dict(LBuffs.buff_data.Poise)
			med_buff["target"] = Global.Player
			med_buff["source"] = Global.Player
			med_buff.duration = 5
			action = {
			"name": "add_buff", 
			"buff": med_buff, 
			"msg": Global.Player.get_traits().CosmicDiscplate.Name
			}
			ProcessQueue.add_effect(action)
		
		if Global.Player.get_traits().has("Fawdaa"):
			var damage = float(Global.rng.randi_range(1, 400))
			var types = ["poison", "death", "psychic", "astral"]
			var type = types[Global.rng.randi_range(0, types.size() - 1)]
			var action = {
			"name": "magic_damage_tiles_in_path_to_targets_in_range", 
			"caster": Global.Player, 
			"damage": damage, 
			"damage_type": type, 
			"effect_sprite": translate.dmgtype_to_animation(type), 
			"number_of_targets": 1, 
			"effect_range": 99, 
			"enemies": null, 
			"msg": Global.Player.get_traits().Fawdaa.Name
				}
			ProcessQueue.add_effect(action)
	
		if unit.get_traits().has("Autoblink"):
			var action = {
			"name": "heal", 
			"amount": unit.get_traits().Autoblink.base, 
			"healer_unit": unit, 
			"healed_unit": unit, 
			"msg": unit_traits.Autoblink.Name
		}
			ProcessQueue.add_effect(action)
	
		if Global.Player.get_traits().has("TransalChakram") == true:
			var trait = Global.Player.get_traits().TransalChakram
			var action = {
			"name": "magic_damage_targets_range", 
			"caster": Global.Player, 
			"damage": 50.0, 
			"damage_type": "astral", 
			"effect_sprite": "Astral", 
			"number_of_targets": 1, 
			"effect_range": 99, 
			"msg": trait.Name
				}
			ProcessQueue.add_effect(action)
	
		if Global.Player.get_traits().has("AstralSeeking") == true:
			var trait = Global.Player.get_traits().AstralSeeking
			
			var action = {
			"name": "magic_damage_targets_range", 
			"caster": Global.Player, 
			"damage": 25.0 * trait.Level, 
			"damage_type": "astral", 
			"effect_sprite": "Astral", 
			"number_of_targets": 1, 
			"effect_range": 99, 
			"msg": trait.Name
				}
			ProcessQueue.add_effect(action)
		
			var med_buff = cloner.clone_dict(LBuffs.buff_data.Meditate)
			med_buff["target"] = Global.Player
			med_buff["source"] = Global.Player
			med_buff.duration = 2 * trait.Level
			action = {
			"name": "add_buff", 
			"buff": med_buff, 
			"msg": Global.Player.get_traits().AstralSeeking.Name
			}
			ProcessQueue.add_effect(action)
		
		if unit.get_traits().has("Starjumper"):
			var action = {
				"name": "magic_damage_tiles_in_range", 
				"caster": unit, 
				"damage": unit.get_total_WIL() * unit.get_total_DEX() * 1.0, 
				"damage_type": "astral", 
				"effect_sprite": "Astral", 
				"effect_range": 3, 
				"msg": unit_traits.Starjumper.Name
			}
			ProcessQueue.add_effect(action)
		
		if unit.get_traits().has("Psychonaut") == true:
			var new_buff = cloner.clone_dict(LBuffs.buff_data.Repulsion)
			new_buff["target"] = unit
			new_buff["source"] = unit
			new_buff.duration = 7
			var action = {
				"name": "add_buff", 
				"buff": new_buff, 
				"msg": unit_traits.Psychonaut.Name
				}
			ProcessQueue.add_effect(action)
		
			

static func text_popup(unit):
	var apoint = unit.get_global_position()
	var atext = "传送"
	var color = "[color=#a030b0]"

	ProcessText.spawn_text_popup(apoint, atext, color)

static func message_teleport(unit, msg):
	
	
	var name_a = unit.get_name_color()

	
	
	var stringa = "..."
	
	
	
	if unit == Global.Player:

		name_a = "You"
		stringa = "你[color=#a030b0]传送[/color]了！"
	else:
		stringa = name_a + " [color=#a030b0]传送[/color]了！"
		
	
	if msg != "":
		stringa += "[color=#707070] <- " + textstrip.strip_bbcode(msg)
	
	return stringa
