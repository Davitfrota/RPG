extends Node

var Mapa1 = load("res://Videos & Audio/Audio/medieval_music_knights_of_blackhall_1672648659780765144.ogg")
var Mapa2 = load("res://Videos & Audio/Audio/dwarf_mining_music_dwarf_mining_town_126765102039907433.ogg")
var Mapa3 = load("res://Videos & Audio/Audio/medieval_music_cobblestone_village_Wqn3_nIByoK-gucZ5bdc.ogg")
var Mapa3Castle = load("res://Menu/hunter_x_hunter_2011_ost_3_riot_-3469106857905663068.ogg")
var Death = load("res://Videos & Audio/Audio/DeathMusic.wav")
var Tavern = load("res://Videos & Audio/Audio/Tavern Music.wav")
var Menu = load("res://Videos & Audio/Audio/isabella_s_lullaby_the_promised_neverland_lofi_-7433177121852572551.ogg")
var Demon = load("res://Videos & Audio/Audio/Gozada_do_Davi-consolidated.wav")

func Mapa1_music():
	$Music.stream = Mapa1
	$Music.play()

func Mapa2_music():
	$Music.stream = Mapa2
	$Music.play()

func Mapa3_music():
	$Music.stream = Mapa3
	$Music.play()

func Mapa3Castle_music():
	$Music.stream = Mapa3Castle
	$Music.play()

func Death_music():
	$Music.stream = Death
	$Music.play()

func Tavern_music():
	$Music.stream = Tavern
	$Music.play()

func Demon_sound():
	$Music.stream = Demon
	$Music.play()

func Menu_music():
	$Music.stream = Menu
	$Music.play()
	
func Mute():
	$Music.volume_db = -100
func desMute():
	$Music.volume_db = 0
