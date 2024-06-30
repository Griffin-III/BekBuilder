extends Container

@onready var vhSplitScene = preload("res://UI/VHSplit.tscn")
@onready var tabPanelScene = preload("res://UI/TabPanel.tscn")



func _input(event):
	if event.is_action_pressed("EditUI"):
		# show EditUI and make it, and other editable controls, interactable
		visible = true
		get_tree().call_group("Draggable", "editUIShow")

	if event.is_action_released("EditUI"):
		visible = false
		get_tree().call_group("Draggable", "editUIHide")




# ------------- EditUI Button Signals ---------------


func _on_addHSplit():
	addVHSplit(false)

func _on_addVSplit():
	addVHSplit(true)

func addVHSplit(vertical):
	var nodeToMove = get_parent()
	var parentTab = nodeToMove.get_parent()
	var n = vhSplitScene.instantiate()
	nodeToMove.add_sibling(n)

	if vertical:
		n.vertical = true

	# Checks to see if the parent is a Tab Panel. If so, swap out the existing panel tied to that tab
	if parentTab.is_in_group("TabPanel"):
		parentTab.tabBar.swapTab(n, false)

	nodeToMove.get_parent().remove_child(nodeToMove)
	n.add_child(nodeToMove)
	# Add a new Widget Panel to the other side of the split
	SceneManager.addWidgetPanel(n)



func _on_AddTabPanel():
	var nodeToMove = get_parent()
	var parentTab = nodeToMove.get_parent()
	var n = tabPanelScene.instantiate()
	# The Tab Bar actually handles tabs, n is just the parent vertical split container that divides it from tabs
	var t = n.tabBar

	nodeToMove.add_sibling(n)
	nodeToMove.get_parent().remove_child(nodeToMove)
	n.add_child(nodeToMove)

	t.editUIShow()
	t.addTab()
	# Move the node we're currently using into the position of the first tab and delete the new node that was created by addTab
	t.swapTab(nodeToMove, true)

	if parentTab.is_in_group("TabPanel"):
		parentTab.tabBar.swapTab(n, false)	



func _on_Config():
	# Will show a menu to let you choose which widget goes in this panel and change widget settings
	pass



func _on_Remove():
	var panelToRemove = get_parent()
	var panelParentToRemove = panelToRemove.get_parent()

	
	# I still feel like this could be optimized, but only if the number of groups increases enough for array.any = array.any to make sense
	if panelParentToRemove.is_in_group("VHSplit") || panelParentToRemove.is_in_group("WidgetPanel") || panelParentToRemove.is_in_group("TabPanel"):
		# Panels mostly handle their own movement. This tells them to try moving up to their parent and change which node EditUI is attached to
		SceneManager.findNextEditUIParent(panelParentToRemove.moveUp(panelToRemove))
		SceneManager.changeEditUIParent()
		# We specifically don't use queue_free because that gives WidgetPanel a chance to detect the mouse has entered and change EditUI's parent to a node that will soon be deleted
		panelParentToRemove.free()