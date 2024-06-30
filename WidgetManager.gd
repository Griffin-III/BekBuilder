extends Node

# I haven't looked at this since starting the project. Need to review


func startup():
	# check for widgets. turn widgets into classes, get widget versions, update scripts

	# check PATH for widgets. for each valid scene file set its current folder as its path (duh) so it knows where to look for assets
	var appFiles= IoManager.getFilelist("res://Widgets", ["tscn"]) # Extension *without* the dot
	#print("Getting built-in widgets")
	for f in appFiles:
		# actually need to check the scene for something indicating it's a widget root and not some other scene
		#print(f)
		pass
	var userFiles= IoManager.getFilelist("user://Widgets", ["tscn"]) # Extension *without* the dot
	#print("Getting user widgets")
	for f in userFiles:
		#print(f)
		pass


func returnActiveWidgets():
	# return list of widgets currently in use
	pass

func widgetsPopulateList():
	pass