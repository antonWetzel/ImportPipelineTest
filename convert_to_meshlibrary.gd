@tool
extends ImportPipelineStep

@export var scene: PackedScene
@export var library: MeshLibrary

@export var only_top_level_meshes: bool = false

func _get_display_name() -> String: return "Convert to MeshLibrary"
func _get_inputs() -> PackedStringArray: return PackedStringArray(["scene"])
func _get_outputs() -> PackedStringArray: return PackedStringArray(["library"])

func _update() -> void:
	if scene == null:
		library = null
		return
	var node: Node = scene.instantiate()
	library = MeshLibrary.new()
	iterate(node, true)
	node.queue_free()

func iterate(node: Node, recursive: bool) -> void:
	if node is MeshInstance3D:
		var id := library.get_last_unused_item_id()
		library.create_item(id)
		library.set_item_mesh(id, node.mesh)
		library.set_item_name(id, node.name)
	if recursive:
		for child in node.get_children():
			iterate(child, !only_top_level_meshes)
