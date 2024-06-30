extends Node

# I haven't looked at this since starting the project. Need to review

func startup():
	# check for saves, check save versions and prompt for updates. widgets have individual versions
	# might need more checks on this function in the future
	# very few settings will 
	if IoManager.fileExistCreate("Settings.yml"):
		# fill in the settings file from default values
		pass
	else:
		# load settings
		pass

	




func settingsSave():
	# saves main bekbuilder settings
	pass

func settingsLoad():
	pass



func characterSave():
	# gather data from each widget and pack it into a file. yaml?
	# I want everything in plain text so saves can be recovered easily
	pass

func characterLoad():
	pass

func characterOverwriteSave():
	pass

func characterDeleteSave():
	pass

func characterDelete():
	pass

func characterPopulateSaveList():
	# pass the saves to display in the menu
	pass

func characterPopulateList():
	pass





func campaignSave():
	pass

func campaignLoad():
	pass

func campaignOverwriteSave():
	pass

func campaignDeleteSave():
	pass

func campaignDelete():
	pass

func campaignPopulateList():
	pass




func presetSave():
	pass

func presetLoad():
	pass

func presetOverwrite():
	pass

func presetDelete():
	pass

func presetPopulateList():
	pass