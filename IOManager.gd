extends Node

# I haven't looked at this since starting the project. Need to review

func _ready():
	startup()


func startup():
	# Check user directory for existence, proper sub structure
	var baseDirs = ["", "Widgets", "Characters", "Presets", "Campaigns", "Cache"]
	# Widgets. Each contains its own game data, like items and spells
	# Characters. Individual Character storage. Does not store multiplayer data
	# Presets for layouts, characters, campaigns, etc.
	# Separate from Characters for DM's. Can also serve as shared campaign data for multiplayer
	# Separate cache folder or file for each widget. idk how a cache would help here but it might for large widgets

	# Settings.yaml is handled by SaveManager. It is the only other file that needs to be created
	# other possible files include a widget.yaml containing a list of all widgets and enabled/disabled if that speeds things up

	for b in baseDirs:
		dirExistCreate(b)
		
	# start Widgets and Saves after IO setup has finished
	WidgetManager.startup()
	SaveManager.startup()


func dirExistCreate(dire):
	var dir = DirAccess.open("user://")
	if !dir.dir_exists(dire):
		#print("No " + dire + " folder. Creating...")
		dir.make_dir(dire)
		return true

func fileExistCreate(filee):
	var dir = DirAccess.open("user://")
	if !dir.file_exists(filee):
		#print("No " + filee + " file. Creating...")
		#dir.make_file(filee)
		return true



func getFilelist(scanDir : String, filterExts : Array = []) -> Array:
	var myFiles : Array = []
	
	var dir = DirAccess.open(scanDir)
	#dir.make_dir("Widgets")

	if !dir:
		printerr("Warning: shit fucked: ", scanDir)
		#print(DirAccess.get_open_error())
		return myFiles

	# these 2 errors don't work. fix
	#if !dir.dir_exists(scanDir):


	#if dir.list_dir_begin() != OK:


	
	dir.list_dir_begin()



	var fileName = dir.get_next()
	while fileName != "":
		if dir.current_is_dir():
			myFiles += getFilelist(dir.get_current_dir() + "/" + fileName, filterExts)
		else:
			if filterExts.size() == 0:
				myFiles.append(dir.get_current_dir() + "/" + fileName)
			else:
				for ext in filterExts:
					if fileName.get_extension() == ext:
						myFiles.append(dir.get_current_dir() + "/" + fileName)
		fileName = dir.get_next()
	return myFiles
