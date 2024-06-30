extends Container

func _on_mouse_entered():
	SceneManager.addEditUIParent(self)

func moveUp(_nodeToRemove):
	# This was here and I don't know why. Leftover from VHSplit? Doesn't seem to break anything. Remove 
	# var nodeToSave = get_child(0)
	# if nodeToSave == nodeToRemove:
	# 	nodeToSave = get_child(1)

	var nodeToMoveTo = get_parent()
	get_parent().remove_child(self)
	nodeToMoveTo.add_sibling(self)

	return self
