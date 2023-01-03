@tool
extends ImportPipelineStep

@export var resource: Resource

@export_file("*.res") var path: String

func _get_display_name() -> String: return "Save"
func _get_inputs() -> PackedStringArray: return PackedStringArray(["resource"])

func _update() -> void:
	var res := resource.duplicate()
	res.take_over_path(path)
	ResourceSaver.save(res, path)
