extends Node

@onready var widgetPanelScene = preload("res://UI/WidgetPanel.tscn")

@onready var newParent = get_node("/root/MainUI/WidgetPanel")
@onready var editUI = newParent.get_node("EditUI")

# This comment is some dumb optimization I don't need to do but I preferred having all of this on EditUI directly rather than this passing vars around
# But forwarding functions through SceneManager to EditUI seems even worse so I guess I'll leave this

func _process(_delta):
	if Input.is_action_pressed("EditUI"):
		if editUI.get_parent() != newParent:
			changeEditUIParent()


func findNextEditUIParent(node):
	# finds the next possible WidgetPanel that this EditUI can attach to
	if node == null:
		return
	if node.is_in_group("WidgetPanel"):
		addEditUIParent(node)
		#print("Found a good node: " + str(editParent))
		return node
	else:
		for childnode in node.get_children():
			var foundnode = findNextEditUIParent(childnode)
			if foundnode != null:
				#print("Found a split. Searching next level...")
				return foundnode

func addEditUIParent(node):
	newParent = node

func changeEditUIParent():
	editUI.get_parent().remove_child(editUI)
	newParent.add_child(editUI)

func addWidgetPanel(node):
	var n = widgetPanelScene.instantiate()
	node.add_child(n)
	return n