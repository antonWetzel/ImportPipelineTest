@tool
extends ImportPipelineStep

@export var in_resource: Resource

@export_file("*.res") var path: String

func _update() -> void:
	var res := in_resource.duplicate()
	res.take_over_path(path)
	ResourceSaver.save(res, path)

func _get_display_name() -> String: return "Save"
