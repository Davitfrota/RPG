extends Node

var client
var wrapped_client
var connected = false

var text = ""

signal sobe(player)
signal desce(player)
signal potenciometro(player, value)
signal sound(player)

func _ready():
	client = StreamPeerTCP.new()
	client.set_no_delay(true)
	
func _exit_tree():
	disconnect_from_server()

func connect_to_server():
	var ip = "192.168.0.110"
	var port = 80
	print("Connecting to server: %s : %s" % [ip, str(port)])
	var connect = client.connect_to_host(ip, port)
	if client.is_connected_to_host():
		connected = true
		print("Connected!")
	
func disconnect_from_server():
	connected = false
	client.disconnect_from_host()

func _process(delta):
	if not connected:
		pass
	if connected and not client.is_connected_to_host():
		connected = false
	if client.is_connected_to_host():
		poll_server()


func poll_server():
	while client.get_available_bytes() > 0:
		var msg = client.get_utf8_string(client.get_available_bytes())
		if msg == null:
			continue;
			
		if msg.length() > 0:
			for c in msg:
				if c == "\n":
					on_text_received(text)
					text = ""
				else:
					text+=c

func on_text_received(text): #"1 Sobe"
	var command_array = text.split(" ")
	print(command_array)
	if command_array.size() < 2:
		return
		
	if str(command_array[1]) == "Sobe":
		emit_signal("sobe", command_array[0])
	elif command_array[1] == "Desce":
		emit_signal("desce", command_array[0])
	elif command_array[1] == "Sound":
		emit_signal("sound", command_array[0])
#	else:
#		emit_signal("potenciometro", command_array[0], command_array[1])

func write_text(text):
	if connected and client.is_connected_to_host():
		print("Sending: %s" % text)
		client.put_data(text.to_ascii())
