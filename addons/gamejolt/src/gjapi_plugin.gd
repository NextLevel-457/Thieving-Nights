@tool
extends EditorPlugin


func _enter_tree():
	# When this plugin node enters tree, add the custom type

	add_custom_type("GameJoltAPI", "HTTPRequest", preload("main.gd"), preload("gj_icon.png"))

func _exit_tree():
	# When the plugin node exits the tree, remove the custom type

	remove_custom_type("GameJoltAPI")




	
