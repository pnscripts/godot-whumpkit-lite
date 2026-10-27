class_name WhumpkitLite
extends RefCounted
## Script handles for the Whumpkit Lite components, so game code can write
## [code]WhumpkitLite.Shake2D.new()[/code] or [code]node is WhumpkitLite.HitStop[/code].
##
## Whumpkit Lite by PN Scripts, MIT licence.

const Shake2D := preload("res://addons/whumpkit_lite/whumpkit_shake_2d.gd")
const Shake3D := preload("res://addons/whumpkit_lite/whumpkit_shake_3d.gd")
const HitStop := preload("res://addons/whumpkit_lite/whumpkit_hit_stop.gd")


## First direct child of [param node] that uses [param script], or null.
static func find(node: Node, script: Script) -> Node:
	for child in node.get_children():
		if child.get_script() == script:
			return child
	return null
