extends Node

class_name score



static func build_score_elements():
	StatePlayerSheet.score_data["name"] = "[color=#ffff50]" + str(Global.Player.get_name()) + "[/color][color=#c0c0c0]，[/color]" + StatePlayerSheet.title_race + " " + StatePlayerSheet.title_class + "[color=#c0c0c0]，信仰[/color] " + StatePlayerSheet.God.name
	StatePlayerSheet.score_data["place"] = StateWorld.tileset.description
	StatePlayerSheet.score_data["place_sprite"] = "res://Ham_Sprite/World/" + StateWorld.tileset.world_icon + ".png"
	StatePlayerSheet.score_data["place_suffix"] = StateWorld.tileset.description_suffix
	StatePlayerSheet.score_data["day"] = StateWorld.day
	StatePlayerSheet.score_data["cycle"] = StateWorld.cycle

	StatePlayerSheet.score_data["body"] = StatePlayerSheet.sprite_skin
	StatePlayerSheet.score_data["inventory"] = []
	player_body_element("main")
	player_body_element("off")
	player_body_element("head")
	player_body_element("hand")
	player_body_element("leg")
	player_body_element("chest")
	
	StatePlayerSheet.score_data["powers"] = []
	StatePlayerSheet.score_data["traits"] = []
	
	
	
	
	var list = Global.Player.get_traits()
	for trait in list:
		var traitreal = cloner.clone_dict(list[trait])
		if traitreal.generic == false:
			StatePlayerSheet.score_data["powers"].append(traitreal)
		else:
			StatePlayerSheet.score_data["traits"].append(traitreal)
	
	StatePlayerSheet.score_data["str"] = Global.Player.get_total_STR()
	StatePlayerSheet.score_data["dex"] = Global.Player.get_total_DEX()
	StatePlayerSheet.score_data["wil"] = Global.Player.get_total_WIL()
	StatePlayerSheet.score_data["life"] = Global.Player.HP_max

static func player_body_element(label):
	if Global.Player.get_item_from_label(label) != null:
		StatePlayerSheet.score_data[label] = Global.Player.get_item_from_label(label).sprite
		StatePlayerSheet.score_data["inventory"].append(Global.Player.get_item_from_label(label))
	else:
		StatePlayerSheet.score_data[label] = "none"
