@tool
extends ImportPipelineStep

@export var scene: PackedScene
@export var addition: PackedScene
@export var result: PackedScene

@export var merge_point: NodePath

func _get_display_name() -> String: return "Add Sceene"
func _get_inputs() -> PackedStringArray: return PackedStringArray(["scene", "addition"])
func _get_outputs() -> PackedStringArray: return PackedStringArray(["result"])

func _update() -> void:
	pass #todo
