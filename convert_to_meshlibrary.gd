@tool
extends AdvancedImportStep

@export var only_top_level_meshes: bool = false

func _transform() -> Resource:
	if get_source() is PackedScene == false:
		printerr("not a PackedScene")
		return Resource.new()
	var scene: Node = get_source().instantiate()
	var library = MeshLibrary.new()
	iterate(scene, library, true)
	scene.queue_free()
	return library

func _get_display_name() -> String: return "Convert to MeshLibrary"

func iterate(node: Node, library: MeshLibrary, recursive: bool) -> void:
	if node is MeshInstance3D:
		var id := library.get_last_unused_item_id()
		library.create_item(id)
		library.set_item_mesh(id, node.mesh)
		library.set_item_name(id, node.name)
	if recursive:
		for child in node.get_children():
			iterate(child, library, !only_top_level_meshes)
