extends SplitContainer

func editUIShow():
	dragger_visibility = 0 as SplitContainer.DraggerVisibility

func editUIHide():
	dragger_visibility = 1 as SplitContainer.DraggerVisibility

func moveUp(nodeToRemove):
	var nodeToSave = get_child(0)
	if nodeToSave == nodeToRemove:
		nodeToSave = get_child(1)
	
	remove_child(nodeToSave)
	add_sibling(nodeToSave)

	var parentTab = get_parent()
	if parentTab.is_in_group("TabPanel"):
		parentTab.tabBar.swapTab(nodeToSave, true)

	return nodeToSave