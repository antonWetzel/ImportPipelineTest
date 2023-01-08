@tool
extends ImportPipelineStep

@export var scene: PackedScene
@export var addition: PackedScene
@export var result: PackedScene
@export var addition_path: NodePath

var tree: Node = null

func _get_display_name() -> String: return "Combine Scenes"
func _get_inputs() -> PackedStringArray: return PackedStringArray(["scene", "addition"])
func _get_outputs() -> PackedStringArray: return PackedStringArray(["result"])

func _source_changed():
	if tree != null:
		tree.queue_free()
		tree = null
	if scene != null:
		tree = scene.instantiate()

func _notification(what: int):
	match what:
		NOTIFICATION_PREDELETE:
			if tree != null:
				tree.queue_free()

func _update() -> void:
	if tree == null or addition == null:
		result = null
		return
	result = PackedScene.new()
	if tree.has_node(addition_path):
		var add = addition.instantiate()
		tree.get_node(addition_path).add_child(add)
		change_owners(add, tree)
		result.pack(tree)
		add.queue_free()
	else:
		result.pack(tree)

func change_owners(node: Node, owner: Node):
	node.owner = owner
	for child in node.get_children():
		change_owners(child, owner)

func _get_tree():
	return tree
