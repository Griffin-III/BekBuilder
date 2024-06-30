extends SplitContainer

@export var tabBar : Node


func moveUp(_node):
	# If we have many tabs just remove everything and make a new panel
	if tabBar.tab_count > 2 || get_parent().is_in_group("TabPanel"):
		var n = SceneManager.addWidgetPanel(self)
		remove_child(n)
		add_sibling(n)

		if get_parent().is_in_group("TabPanel"):
			get_parent().tabBar.swapTab(n, true)
		return n

	else:
		# Save sibling container and move it up
		var nodeToSave = get_child(1)

		remove_child(nodeToSave)
		add_sibling(nodeToSave)
		return nodeToSave