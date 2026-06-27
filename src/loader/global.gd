extends Node

var zh_patch_path = OS.get_executable_path().get_base_dir().plus_file("poa_zh.pck")
var zh_patch_loaded = ProjectSettings.load_resource_pack(zh_patch_path, true)

var export_type = "desktop"
var test = true
var os_type = ""
var last_score_data = {}


var testmode = false



var game_offset_x = 88
var game_offset_y = 102

var version = "Path of Achra 中文补丁 desktop"
var version_number = 3

var lifelength = 30
var bagsize = 33
var TileNode = preload("res://Scenes/Tile.tscn")
var TileWorldNode = preload("res://Scenes/Tile_World.tscn")
var PlayerNode = preload("res://Scenes/Player.tscn")
var ItemNode = preload("res://Scenes/Item.tscn")
var EnemyNode = preload("res://Scenes/Enemy.tscn")
var TextPopup = preload("res://Scenes/Text_Popup.tscn")
var EffectNode = preload("res://Scenes/Effect.tscn")
var EffectAnimated = preload("res://Scenes/EffectAnimated.tscn")
var DelayedEvent = preload("res://Scenes/Delayed_Event.tscn")

var Level_StartMenu = load("res://Scenes/StartMenu.tscn")
var Level_Game = preload("res://Scenes/Game.tscn")
var Level_Start = load("res://Scenes/Start_Menu.tscn")
var Level_First = load("res://Scenes/First_Menu.tscn")
var Level_Score = preload("res://Scenes/ScoreScreen.tscn")
var Level_Graveyard = preload("res://Scenes/Graveyard.tscn")
var Level_Bestiary = load("res://Scenes/Bestiary.tscn")
var Level_AbilityBook = load("res://Scenes/AbilityBook.tscn")
var Level_Armory = load("res://Scenes/Armory.tscn")
var Level_Feats = load("res://Scenes/Feats.tscn")
var Level_Credits = preload("res://Scenes/Credits.tscn")
var Verse = preload("res://Scenes/Verse.tscn")

var EffectScreen = load("res://Scenes/UI_Level_Up.tscn")

var UITraits = load("res://Scenes/UI_Traits_Basic.tscn")
var UIInv = load("res://Scenes/UI_Inv.tscn")
var UIGod = preload("res://Scenes/UI_God.tscn")
var UIPopup = preload("res://Scenes/UI_Popup.tscn")
var UIPopupNongame = preload("res://Scenes/UI_Popup_Nongame.tscn")
var UILog = preload("res://Scenes/UI_Log.tscn")
var UIMenu = preload("res://Scenes/UI_GameMenu.tscn")
var UIPrestige = load("res://Scenes/UI_Prestige.tscn")

var ButtonInformation = preload("res://Scenes/Button_Information.tscn")
var ButtonBag = preload("res://Scenes/Button_Bag.tscn")
var ButtonInvoke = preload("res://Scenes/Button_Invoke.tscn")
var ButtonInfoNode = preload("res://Scenes/Button_Info.tscn")
var ButtonNode = preload("res://Scenes/Button.tscn")
var ButtonTraitNode = preload("res://Scenes/Button_Traits_UI.tscn")
var ButtonStartNode = preload("res://Scenes/Button_StartMenu.tscn")
var ButtonBuff = preload("res://Scenes/Button_Buff.tscn")
var ButtonEnemyCont = preload("res://Scenes/Button_Enemy_Cont.tscn")
var ButtonBeast = preload("res://Scenes/ButtonBeast.tscn")
var ButtonAbilityBook = preload("res://Scenes/ButtonAbilityBook.tscn")
var ButtonMaqbara = preload("res://Scenes/ButtonMaqbara.tscn")
var ButtonArmory = preload("res://Scenes/ButtonArmory.tscn")
var FeatButton = preload("res://Scenes/FeatButton.tscn")

var SoundEffect = preload("res://Scenes/Sound_Effect.tscn")
var Music = preload("res://Scenes/Music.tscn")

var Transition = preload("res://Scenes/Transition.tscn")


var selected_maqbara = ""


var Tile_Size = 32
enum Tile_Type{GROUND, WALL, STAIRS}

var Tile = []
var Tile_Ground = []
var Tile_Wall = []

var Tile_XY = []

var cycle_taper = 40

var Enemies = []
var Enemies_Dead = []
var Allies = []
var Allies_Dead = []

var Level_Width = 16
var Level_Height = 10

var sound = null
var game = null
var Player = null
var universal = null
var continent = null

var start_menu = null

var race_data = []
var class_data = []
var god_data = []

var inv_glow = false
var trait_glow = false


var added_glory = 0

var options_menu_open = false

var contspace_x = 32
var contspace_y = 32


var summon_order = "attack"



var rng = null

var bestiary_selected = "none"
var armory_selected = "none"


func _ready():
	

	
	rng = RandomNumberGenerator.new()
	rng.randomize()

func get_allies_size_minus_familiars():
	var inta = Allies.size()
	for ally in Allies:
		if ally != Player:
			if ally.type.abilities.has("Familiar") == true:
				inta -= 1
	return inta

func clear_level_data():
	Tile = []
	Tile_Ground = []
	Tile_Wall = []
	Tile_XY = []
	Enemies = []
	Enemies_Dead = []
	Allies = []
	Allies_Dead = []
	ProcessQueue.queue_effects = []
	game = null
	Player = null
