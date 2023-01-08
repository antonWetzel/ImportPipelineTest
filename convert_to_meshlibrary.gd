@tool
extends ImportPipelineStep

@export var scene: PackedScene
@export var library: MeshLibrary

func _get_display_name() -> String: return "Convert to MeshLibrary"
func _get_inputs() -> PackedStringArray: return PackedStringArray(["scene"])
func _get_outputs() -> PackedStringArray: return PackedStringArray(["library"])

func _update() -> void:
	if scene == null:
		library = null
		return
	var tree = scene.instantiate()
	library = MeshLibrary.new()
	iterate(tree)

func iterate(node: Node) -> void:
	if node is MeshInstance3D:
		var id := library.get_last_unused_item_id()
		library.create_item(id)
		library.set_item_mesh(id, node.mesh)
		library.set_item_name(id, node.name)
	for child in node.get_children():
		iterate(child)
