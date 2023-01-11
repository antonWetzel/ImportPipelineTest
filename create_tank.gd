@tool
extends ImportPipelineStep

@export var body: PackedScene
@export var top: PackedScene
@export var cannon: PackedScene
@export var material: Material
@export var height: float
@export var result: PackedScene

func _update() -> void:
	if body == null or top == null or cannon == null:
		result = null
		return
	var body_node := body.instantiate() as MeshInstance3D
	body_node.mesh = body_node.mesh.duplicate()
	body_node.mesh.surface_set_material(0, material)

	var top_node := top.instantiate() as MeshInstance3D
	top_node.mesh = top_node.mesh.duplicate()
	top_node.mesh.surface_set_material(0, material)
	top_node.position.y = height
	body_node.add_child(top_node)
	top_node.owner = body_node

	var cannon_node := cannon.instantiate() as MeshInstance3D
	cannon_node.mesh = cannon_node.mesh.duplicate()
	cannon_node.mesh.surface_set_material(0, material)
	cannon_node.position.y = 0
	top_node.add_child(cannon_node)
	cannon_node.owner = body_node

	result = PackedScene.new()
	result.pack(body_node)

	body_node.queue_free()

func _get_inputs():
	return PackedStringArray(["body", "top", "cannon", "material"])

func _get_outputs(): return PackedStringArray(["result"])
