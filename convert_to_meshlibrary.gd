@tool
class_name ConvertToMeshLibrary extends ImportPipelineStep

@export var in_scene: PackedScene
@export var out_library: MeshLibrary

@export var only_top_level_meshes: bool = false

func _update() -> void:
	if in_scene == null:
		out_library = null
		return
	var scene: Node = in_scene.instantiate()
	out_library = MeshLibrary.new()
	iterate(scene, true)
	scene.queue_free()

func _get_display_name() -> String: return "Convert to MeshLibrary"

func iterate(node: Node, recursive: bool) -> void:
	if node is MeshInstance3D:
		var id := out_library.get_last_unused_item_id()
		out_library.create_item(id)
		out_library.set_item_mesh(id, node.mesh)
		out_library.set_item_name(id, node.name)
	if recursive:
		for child in node.get_children():
			iterate(child, !only_top_level_meshes)
