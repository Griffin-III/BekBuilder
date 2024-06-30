extends TabBar

var tabIcon = preload("res://UI/NewTab.png")
var tabRearranged
@export var tabMenu : Node

func _ready():
	# First tab is the NewTab button. Can't hide in editor for some reason so hide here
	set_tab_hidden(0, true)

# ------------ Node management ---------------------

func editUIShow():
	drag_to_rearrange_enabled = true
	updateNewTabPos()
	set_tab_hidden(tab_count - 1, false)


func editUIHide():
	set_tab_hidden(tab_count - 1, true)
	drag_to_rearrange_enabled = false


func moveUp(_nodeToRemove):
	printerr("This is actually called? Should be impossible. Identify bug immediately and eliminate")


# ------------ Signals ---------------------

func _input(event):
	if tabMenu.visible:
		if (event is InputEventMouseButton) and event.pressed:
			if !tabMenu.get_rect().has_point(get_local_mouse_position()):
				tabMenu.visible = false


func _on_tab_rmb_clicked(_tab:int):
	# open a menu on the mouse's position regardless of holding alt to rename, remove, or select tab icon
	tabMenu.position = get_local_mouse_position()
	tabMenu.visible = true
	tabMenu.changeName.text = get_tab_title(current_tab)
	# Disable the close tab button if there's not enough tabs. User should use the remove panel button if they want to remove a tab panel
	if tab_count < 3:
		tabMenu.closeTab.disabled = true
	else:
		tabMenu.closeTab.disabled = false

	

func _on_close_tab_pressed():
	# Button should be disabled but we still check
	if tab_count > 2:
		removeTab(current_tab)
		tabMenu.visible = false

func _on_change_icon_pressed():
	# some kind of popup that lets you select from files in user:// dir. Should we have a built in asset chooser from things user has added or load system filepicker?
	# I am fully expecting icons to break containers somehow. I can't get scaling to work properly so they need to be like 16x16
	pass

func _on_name_changed(new_text:String):
	set_tab_title(current_tab, new_text)

func _on_change_name_enter(_new_text:String):
	# when user presses the return button close the window
	tabMenu.visible = false


func _on_active_tab_rearranged(_idx_to:int):
	# this solves a dumb bug where arranging a tab after the last item also changes it to what used to be the last item, causing it to make new tabs. I think something else is wrong, will revisit
	tabRearranged = true
	updateNewTabPos()




func _on_tab_changed(tab:int):
	if get_tab_metadata(tab) == null:
		# this solves a dumb bug where arranging a tab after the last item also changes it to what was the last item. I think something else is wrong, will revisit
		if tabRearranged:
			tabRearranged = false
			current_tab = current_tab - 1
		else:
			addTab()
	else:
		changeTab(tab)


# ------------ Script functions ---------------------


func updateNewTabPos():
	# Move the NewTab button to the end. Easier to loop through than try to save its position all of the time
	for tab in tab_count - 1:
		# All tabs should have a node except NewTab which has nothing. Faster than looking for icon
		if get_tab_metadata(tab) == null:
			move_tab(tab, tab_count - 1)

func addTab():
	add_tab("New Tab " + str(tab_count - 1))
	var n = SceneManager.addWidgetPanel(get_parent())
	set_tab_metadata(tab_count - 1, n)
	updateNewTabPos()
	changeTab(tab_count - 2)



func swapTab(node, deleteOld):
	if deleteOld:
		get_tab_metadata(current_tab).queue_free()
	# godot docs DO NOT explain metadata. It can be anything, and they explain that fact nowhere. The TabBar and Variant pages are garbage. I almost switched to TabContainer
	# set_tab_metadata(tabInt, nodeTabShouldUse)
	set_tab_metadata(current_tab, node)
	changeTab(current_tab)



func changeTab(tab):
	# could be more efficient to save the previous tab and directly call it but this solves any bugs where it enables other tabs we don't know of
	for t in tab_count - 1:
		var tv = get_tab_metadata(t)
		if tv != null:
			tv.visible = false
	var tabv = get_tab_metadata(tab)
	tabv.visible = true
	# Just to make sure we're actually on the right tab
	current_tab = tab
	SceneManager.findNextEditUIParent(tabv)
	SceneManager.changeEditUIParent()




func removeTab(tab):
	# Change tabs before removing one
	if select_previous_available():
		changeTab(tab - 1)
	else:
		select_next_available()
		changeTab(tab + 1)

	get_tab_metadata(tab).free()
	remove_tab(tab)















