extends Node

class_name translate


static func damage_type(label):
	var stringa = ""
	label = str(label).to_lower()
	match label:
		"pierce":
			stringa += "[color=#af8f50]穿刺[/color]"
		"slash":
			stringa += "[color=#af8f50]斩击[/color]"
		"blunt":
			stringa += "[color=#af8f50]钝击[/color]"
		"blood":
			stringa += "[color=#ff1010]鲜血[/color]"
		"fire":
			stringa += "[color=#ff7000]火焰[/color]"
		"lightning":
			stringa += "[color=#0060ff]闪电[/color]"
		"astral":
			stringa += "[color=#8030af]星界[/color]"
		"poison":
			stringa += "[color=#70ff00]毒素[/color]"
		"psychic":
			stringa += "[color=#ffaf30]灵能[/color]"
		"death":
			stringa += "[color=#a0a000]死亡[/color]"
		"ice":
			stringa += "[color=#5080ff]寒冰[/color]"

	return stringa

static func unit_tag(tag):
	var stringa = tag
	if "Fungus" in tag:
		stringa = tag.replace("Fungus", "真菌")
	elif "Plant" in tag:
		stringa = tag.replace("Plant", "植物")
	elif "Priest" in tag:
		stringa = tag.replace("Priest", "祭司")
	elif "Reptile" in tag:
		stringa = tag.replace("Reptile", "爬行动物")
	elif "Undead" in tag:
		stringa = tag.replace("Undead", "亡灵")
	return stringa

static func element_to_resist_description(element):
	var stringa = ""
	stringa += "[color=#707070]每投入 1 点" + element(element) + "，获得"
	match element:
		"Body":
			stringa += "[color=#ffff00]1%[/color] [color=#af8f50]穿刺[/color]、[color=#af8f50]斩击[/color]和[color=#af8f50]钝击[/color]抗性"
		"Martial":
			stringa += "[color=#ffff00]1%[/color] [color=#af8f50]穿刺[/color]、[color=#af8f50]斩击[/color]和[color=#af8f50]钝击[/color]抗性"
		"Life":
			stringa += "[color=#ffff00]1%[/color] [color=#70ff00]毒素[/color]、[color=#a0a000]死亡[/color]和[color=#ff1010]鲜血[/color]抗性"
		"Astral":
			stringa += "[color=#ffff00]2%[/color] " + element(element) + "抗性"
		"Fire":
			stringa += "[color=#ffff00]2%[/color] " + element(element) + "抗性"
		"Ice":
			stringa += "[color=#ffff00]2%[/color] " + element(element) + "抗性"
		"Death":
			stringa += "[color=#ffff00]2%[/color] " + element(element) + "抗性"
		"Poison":
			stringa += "[color=#ffff00]2%[/color] " + element(element) + "抗性"
		"Ice":
			stringa += "[color=#ffff00]2%[/color] " + element(element) + "抗性"
		"Psychic":
			stringa += "[color=#ffff00]2%[/color] " + element(element) + "抗性"
		"Lightning":
			stringa += "[color=#ffff00]2%[/color] " + element(element) + "抗性"
		"Blood":
			stringa += "[color=#ffff00]2%[/color] " + element(element) + "抗性"
			
	stringa += "[/color]"
	return stringa


static func element_to_points(label):
	var count = 0
	if Global.Player != null:
		var traits = Global.Player.get_traits()
		for title in traits:
			var trait = traits[title]
			if trait.generic == false:
				if trait.Element == label:
					count += trait.Level * trait.cost
	return count

static func value_to_color(integer):
	var stringa = ""
	if integer > 0:
		stringa = "[color=#50ff50]"
	else:
		stringa = "[color=#ff5050]"
		

	return stringa

static func damage_type_to_color(label):
	var stringa = ""
	label = str(label).to_lower()
	match label:
		"pierce":
			stringa += "[color=#af8f50]"
		"slash":
			stringa += "[color=#af8f50]"
		"blunt":
			stringa += "[color=#af8f50]"
		"blood":
			stringa += "[color=#ff1010]"
		"fire":
			stringa += "[color=#ff7000]"
		"lightning":
			stringa += "[color=#0060ff]"
		"astral":
			stringa += "[color=#8030af]"
		"poison":
			stringa += "[color=#70ff00]"
		"psychic":
			stringa += "[color=#ffaf30]"
		"death":
			stringa += "[color=#a0a000]"
		"ice":
			stringa += "[color=#5080ff]"

	return stringa

static func damage_type_to_image(label):
	var stringa = ""
	stringa += "[img]"
	stringa += "res://Ham_Sprite/TextIcons/"
	match label:
		"pierce":
			stringa += "Pierce"
		"slash":
			stringa += "Slash"
		"blunt":
			stringa += "Blunt"
		"blood":
			stringa += "Blood"
		"fire":
			stringa += "Fire"
		"lightning":
			stringa += "Lightning"
		"astral":
			stringa += "Astral"
		"poison":
			stringa += "Poison"
		"psychic":
			stringa += "Psychic"
		"death":
			stringa += "Death"
		"ice":
			stringa += "Ice"
	
	stringa += ".png"
	stringa += "[/img]"
	return stringa

static func element(label):
	var stringa = label
	
	match label:
		"Fire":
			stringa = "[color=#ff8000]火焰[/color]"
		"Death":
			stringa = "[color=#a0a000]死亡[/color]"
		"Lightning":
			stringa = "[color=#0060ff]闪电[/color]"
		"Life":
			stringa = "[color=#00a000]生命[/color]"
		"Body":
			stringa = "[color=#af8f50]武艺[/color]"
		"Martial":
			stringa = "[color=#af8f50]武艺[/color]"
		"Astral":
			stringa = "[color=#8030af]星界[/color]"
		"Psychic":
			stringa = "[color=#ffaf30]灵能[/color]"
		"Poison":
			stringa = "[color=#70ff00]毒素[/color]"
		"Death":
			stringa = "[color=#a0a000]死亡[/color]"
		"Ice":
			stringa = "[color=#5080ff]寒冰[/color]"
		"Blood":
			stringa = "[color=#ff1010]鲜血[/color]"
		
	return stringa

static func trait_name(trait):
	var source = ""
	var title = ""
	if typeof(trait) == TYPE_DICTIONARY:
		if trait.has("Name"):
			source = str(trait.Name)
		if trait.has("title"):
			title = str(trait.title)
	else:
		source = str(trait)
	var plain = textstrip.strip_bbcode(source)
	var translated = trait_name_plain(plain)
	if translated == plain and title != "":
		translated = trait_name_by_title(title, plain)
	return source.replace(plain, translated)

static func trait_name_plain(label):
	var names = {
		"Vinakinesis": "藤蔓念动",
		"Piercing Vines": "穿刺藤蔓",
		"Master Entangle": "缠绕大师",
		"Life Chant": "生命颂唱",
		"Invigoration": "活力激发",
		"Arboromancy": "树灵术",
		"Grove Cult": "林地祭仪",
		"Overgrowth": "疯长",
		"Vineform": "藤蔓形态",
		"Pyrokinesis": "火焰念动",
		"Pyromancy": "火焰术",
		"Shamsar": "日炎",
		"Fire Healing": "火焰疗愈",
		"Frenzied Chant": "狂热颂唱",
		"Immolation": "献祭之焰",
		"Master Scorch": "灼烧大师",
		"Fire Chant": "火焰颂唱",
		"Fire Familiar": "火焰魔宠",
		"Order of Flame": "烈焰教团",
		"Flame Cult": "烈焰祭仪",
		"Newtform": "蝾螈形态",
		"Electrokinesis": "闪电念动",
		"Electromancy": "闪电术",
		"Skera": "电光",
		"Master Charge": "蓄势大师",
		"Chamakana": "满月雷击",
		"Herja": "雷袭",
		"Fulminant Cult": "雷鸣祭仪",
		"Stormcalling": "唤雷",
		"Sparkform": "电火花形态",
		"Psychokinesis": "灵能念动",
		"Psiblade": "灵能刃",
		"Mindfighter": "心灵斗士",
		"Master Repulsion": "斥力大师",
		"Amplify Pain": "痛觉放大",
		"Psychic Retort": "灵能反击",
		"Projective Link": "投射链接",
		"Mass Mind": "群体心智",
		"Mirror Image": "镜像",
		"Toxokinesis": "毒素念动",
		"Poison Skin": "毒皮",
		"Morbumancy": "疫病术",
		"Plague Chant": "瘟疫颂唱",
		"Acidify": "酸化",
		"Burning Ooze": "燃烧软泥",
		"Oozemancy": "软泥术",
		"Poison Familiar": "毒素魔宠",
		"Snakeform": "蛇形态",
		"Fume": "毒雾",
		"Astrokinesis": "星界念动",
		"Cosmic Shield": "宇宙护盾",
		"Asi Malak": "阿西玛拉克",
		"Projection": "投射",
		"Astrostoicism": "星界沉着",
		"Astrohunting": "星界狩猎",
		"Master Teleport": "传送大师",
		"Innervation": "神经支配",
		"Shimmergang": "微光群",
		"Star Cult": "星辰祭仪",
		"Order of the Stars": "群星教团",
		"Heavyweight": "重量级",
		"Guard": "守卫",
		"Heartseeker": "穿心者",
		"Agility": "灵巧",
		"Aim": "瞄准",
		"Pugilism": "拳斗",
		"War Chant": "战斗颂唱",
		"Bheith Nocht": "贝赫诺赫特",
		"Might": "蛮力",
		"Stand Ground": "坚守阵地",
		"Technique": "技法",
		"Warlord": "军阀",
		"Blademaster": "剑术大师",
		"Icewalking": "冰上行走",
		"Cryokinesis": "寒冰念动",
		"Cryomancy": "寒冰术",
		"Isaz": "伊萨兹",
		"Aurora Chant": "极光颂唱",
		"Frostpulse": "霜脉",
		"Obedient Ice": "服从之冰",
		"Frost Armor": "霜甲",
		"Master Freeze": "冻结大师",
		"Ice Familiar": "寒冰魔宠",
		"Crystalform": "水晶形态",
		"Order of Ice": "寒冰教团",
		"Necrokinesis": "死亡念动",
		"Cursed Flesh": "诅咒血肉",
		"Kuga": "库迦",
		"Master Doom": "厄运大师",
		"Grave Chant": "坟墓颂唱",
		"Necromancy": "死灵术",
		"Dread Legion": "恐惧军团",
		"Blight Cult": "枯萎祭仪",
		"Batform": "蝙蝠形态",
		"Hemokinesis": "鲜血念动",
		"Gore Cleave": "血肉劈斩",
		"Gore Chant": "血污颂唱",
		"Roil": "翻涌",
		"Bloodbath": "血浴",
		"Gore Tide": "血潮",
		"Master Bleed": "流血大师",
		"Gore Cult": "血污祭仪",
		"Blood Familiar": "鲜血魔宠"
	}
	if names.has(label):
		return names[label]
	return label

static func trait_name_by_title(title, fallback):
	match title:
		"Tenacity":
			return "重量级"
	return fallback

static func visible_text(text):
	var stringa = str(text)
	var replacements = {
		"Gain +50% Block chance unique": "获得 +50% 格挡概率（唯一）",
		"Block chance": "格挡概率",
		"unique": "唯一",
		"Pierce": "穿刺",
		"Slash": "斩击",
		"Blunt": "钝击",
		"Psychic": "灵能",
		"Astral": "星界",
		"Lightning": "闪电",
		"Poison": "毒素",
		"Death": "死亡",
		"Blood": "鲜血",
		"Fire": "火焰",
		"Ice": "寒冰",
		"Martial": "武艺",
		"Life": "生命",
		"Armor": "护甲",
		"Hit": "命中",
		"Glory": "荣耀",
		"self-damage": "自伤",
		"anything": "任意能力"
	}
	for key in replacements:
		stringa = stringa.replace(key, replacements[key])
	var power_names = ["Heavyweight", "Mindfighter", "Gore Cleave", "Aim", "Bheith Nocht"]
	for key in power_names:
		stringa = stringa.replace(key, trait_name_plain(key))
	return stringa

static func prestige_requirement_text(trait):
	var stringa = prestige.trans_prestige_to_requirement_text(trait)
	stringa = visible_text(stringa)
	stringa = stringa.replace("Requires ", "需要 ")
	stringa = stringa.replace(" points between ", " 点，分配于 ")
	stringa = stringa.replace(" points in any ", " 点，投入任意")
	stringa = stringa.replace(" points in ", " 点，投入 ")
	stringa = stringa.replace(" with ", "，且拥有 ")
	stringa = stringa.replace(" while in ", "，且位于 ")
	stringa = stringa.replace("no powers", "没有能力")
	stringa = stringa.replace("transformation", "变身")
	stringa = stringa.replace("harmful", "有害")
	stringa = stringa.replace("master", "大师能力")
	stringa = stringa.replace("beast familiar", "野兽魔宠")
	stringa = stringa.replace("kinesis", "念动能力")
	stringa = stringa.replace("teleportation", "传送能力")
	stringa = stringa.replace("undead", "亡灵能力")
	stringa = stringa.replace("chant", "颂唱能力")
	stringa = stringa.replace("cult", "祭仪能力")
	stringa = stringa.replace("Ooze", "软泥能力")
	stringa = stringa.replace("Main-hand", "主手")
	stringa = stringa.replace("weapon", "武器")
	stringa = stringa.replace("chest armor", "胸部护甲")
	stringa = stringa.replace("head armor", "头部护甲")
	stringa = stringa.replace("base", "基础")
	stringa = stringa.replace("equipped", "已装备")
	stringa = stringa.replace(" or ", " 或 ")
	stringa = stringa.replace("at least", "至少")
	stringa = stringa.replace("in inventory", "在背包中")
	return stringa

static func dmgtype_to_animation(label):
	var stringa = ""
	match label:
		"pierce":
			stringa += "Pierce"
		"slash":
			stringa += "Slash"
		"blunt":
			stringa += "Blunt"
		"blood":
			stringa += "Blood"
		"fire":
			stringa += "Flame"
		"lightning":
			stringa += "Zap"
		"astral":
			stringa += "Astral"
		"poison":
			stringa += "PoisonHit"
		"psychic":
			stringa += "Psychic"
		"death":
			stringa += "Curse"
		"ice":
			stringa += "Ice"

	return stringa


static func weapon_type_to_scaling(type, stat):
	var stringa = ""
	

	
	var STR = "[color=#a0a0a0]力量[/color]"
	var DEX = "[color=#a0a0a0]敏捷[/color]"
	var WIL = "[color=#a0a0a0]意志[/color]"
	
	match type:
		"light":
			match stat:
				"acc":
					stringa += DEX
				"dmg":
					stringa += DEX + " " + STR
		
		"medium":
			match stat:
				"acc":
					stringa += DEX
				"dmg":
					stringa += DEX + " " + STR
		
		"heavy":
			match stat:
				"acc":
					stringa += DEX + " " + STR
				"dmg":
					stringa += STR
		
		"magic":
			match stat:
				"acc":
					stringa += DEX
				"dmg":
					stringa += WIL
			
						
	return stringa
	

static func get_lines_from_int(inta):
	var stringa = ""
	for n in inta:
		stringa += "|"
	return stringa

static func get_spaced_lines_from_int(inta):
	var stringa = ""
	for n in inta:
		stringa += "| "
	return stringa


static func armor_position(label):
	var stringa = ""
	match label:
		"chest":
			stringa += "chest"
		"head":
			stringa += "head"
		"arm":
			stringa += "arms"
		"leg":
			stringa += "legs"
	return stringa
	

static func is_physical(type):
	var is_physical = false
	
	if type == "blunt" or type == "pierce" or type == "slash":
		is_physical = true
	
	return is_physical
		
static func estimate_hit_chance(attacker, defender):
	var weapon = null
	var is_physical = is_physical(attacker.get_DMG_type(weapon))
	var dmg_type = attacker.get_DMG_type(weapon)
	if attacker == Global.Player:
		weapon = Global.Player.weapon_main
	var dmg = float(attacker.get_DMG_sides(weapon) * attacker.get_DMG(weapon))
	var acc = float(attacker.get_ACC_sides(weapon) * attacker.get_ACC(weapon))
	var dodge = float(defender.get_DEF() * defender.get_DEF_sides())
	var def = float(defender.get_block() * defender.get_block_sides())
	var shield_factor = 1.0
	if is_physical == false:
		shield_factor = 0.25
	var block = float(defender.get_block_strength()) * shield_factor
	var arm = float(defender.get_ARM()) * shield_factor
	var hit_chance = 0.0
	
	dmg = ToolCalcDamage.access_resists(dmg, dmg_type, attacker, defender)
	
	hit_chance = (acc / (acc + dodge))
	if dmg < block * 2:
		hit_chance *= (acc / (acc + def))
	
	hit_chance *= (dmg / (dmg + (arm * 2)))
	
	hit_chance *= 100
	var string = str(int(hit_chance))
	
	return string
	
static func attribute_to_string(label):
	var stringa = ""
	match label:
		"speed":
			stringa = "[color=#20ff20]速度[/color]"
		"life":
			stringa = "[color=#ff8080]生命[/color]"
		"armor":
			stringa = "[color=#5050ff]护甲[/color]"
		"accuracy":
			stringa = "[color=#ffa050]精准[/color]"
		"damage":
			stringa = "[color=#ff8030]伤害[/color]"
		"block":
			stringa = "[color=#5050ff]格挡[/color]"
		"dodge":
			stringa = "[color=#50ffff]闪避[/color]"
	
	return stringa

static func update_trait(trait):
	
	var ref_trait = null
			
	if trait.generic == true:
		if LTraitsGeneric.trait_data.has(trait.title):
				ref_trait = LTraitsGeneric.trait_data[trait.title]
	elif LTraits.trait_data.has(trait.title):
				ref_trait = LTraits.trait_data[trait.title]
				
	if ref_trait != null:
		print("trait updated!!!")
		trait.Description = ref_trait.Description
		trait.Name = ref_trait.Name
		trait.cost = ref_trait.cost
	
	
	return trait


static func check_immune(unit, unit_traits, source, source_traits):
	var immune = false
	
	if unit_traits.has("DamageImmune"):
				immune = true
	
	if Global.Allies.has(unit) == true and unit != source and source == Global.Player:
	
			if source_traits.has("Innervation"):
				immune = true
			if source_traits.has("Invigoration"):
				immune = true
			if source_traits.has("Summoner"):
				immune = true
			if unit.type.title == "PearlMirror":
				immune = true
	
	return immune

static func add_commas(string):
	var i: int = string.length() - 3
	while i > 0:
		string = string.insert(i, ",")
		i = i - 3
	return string

static func is_bare_fist(weapon):
	var boola = false
	if weapon == null:
		boola = true
	elif "Shimmering Orb" in weapon.name:
		boola = true
	elif weapon.has("title"):
		if weapon.title == "mindeye":
			boola = true
		elif weapon.title == "EmeraldEye":
			boola = true
		elif weapon.title == "zclaw":
			boola = true
	
	return boola



static func get_bare_fist_text():
	
	
	var stringa = "[color=#707070]视为“[color=#8040a0]空手[/color]”"
	return stringa


static func get_weapon_name(weapon):
	var stringa = "[color=#ffff50]空手[/color]"
	if weapon != null:
		stringa = weapon.name
	return stringa
	
	
static func damage_type_to_projectile_art(label):
	var stringa = "res://Ham_Sprite/Proj/Proj_Pilum.png"
	match label:
		"slash":
			stringa = "res://Ham_Sprite/Proj/proj_voggite.png"
		"pierce":
			stringa = "res://Ham_Sprite/Proj/Proj_Vine.png"
		"blunt":
			stringa = "res://Ham_Sprite/Proj/proj_voggite.png"
		"fire":
			stringa = "res://Ham_Sprite/Proj/Proj_Fireball.png"
		"ice":
			stringa = "res://Ham_Sprite/Proj/Proj_Ice.png"
		"poison":
			stringa = "res://Ham_Sprite/Proj/Proj_Poison.png"
		"lightning":
			stringa = "res://Ham_Sprite/Proj/Proj_Zap.png"
		"astral":
			stringa = "res://Ham_Sprite/Proj/Proj_Astral.png"
		"psychic":
			stringa = "res://Ham_Sprite/Proj/Proj_Psychic.png"
		"blood":
			stringa = "res://Ham_Sprite/Proj/Proj_Blood.png"
		"death":
			stringa = "res://Ham_Sprite/Proj/Proj_Curse.png"
		

	return stringa


static func count_empty_prayers():
	var invokes = Global.Player.invokes
	var count = 0
	
	for key in invokes:
		var invoke = invokes[key]
		if invoke.level_required <= Global.Player.level:
			count += (invoke.use_max - invoke.use)
	
	return count


static func is_encumbered(unit):
	var boola = true
	if int(unit.get_total_weight()) <= int(unit.get_total_STR()):
			boola = false
	return boola

static func compose_buff_description(buff):
	var stringa = buff.description
	stringa = "[color=#707070]效果：[/color]\n\n"
	return stringa

static func get_shield_or_aoe_text(weapon):
	var stringa = ""
	if weapon.aoe > 1:
		stringa += "\n[img]res://Ham_Sprite/TraitIcons/aoe.png[/img]\n[color=#ff9090]攻击范围区域[/color]"
		stringa += " [color=#a0a0a0]双手持握时[/color]"
		stringa += "\n[color=#707070]需要副手为空[/color]"
	if weapon.has("shield"):
		if weapon.shield == true:
			stringa += "\n[img]res://Ham_Sprite/TraitIcons/Shield.png[/img]\n"
			stringa += "[color=#a0a0a0]获得 +50% [color=#5050ff]格挡概率[/color][/color] [color=#707070]唯一[/color]"
	return stringa




static func element_to_feat(element):
	var stringa = ""
	
	if element == "Body":
		stringa = "martial"
	
	elif element == "Death":
		stringa = "death2"
		
	else: stringa = element.to_lower()
	
	
	return stringa
