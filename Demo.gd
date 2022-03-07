extends Node2D

var first_touch = null
var m_dir := Vector2()
var max_impulse = 600
var max_line_lenght = 200

func _ready():
	pass

func _process(delta):
	
	if first_touch:
		m_dir = get_global_mouse_position() - first_touch
		$Line2D.position = $RigidBody2D.position
		if m_dir.length() > max_line_lenght:
			m_dir = m_dir.normalized() * max_line_lenght
		var hue = (160 + m_dir.length()) / 360
		$Line2D.default_color = Color.from_hsv(hue, 1.0, 1.0)
		$Line2D.set_point_position(1, m_dir.rotated(PI))
		
	if Input.is_action_just_pressed("left_click"):
		first_touch = get_global_mouse_position()
		$Line2D.position = $RigidBody2D.position
		$Line2D.set_point_position(1, Vector2.ZERO)
		$Line2D.visible = true

	if Input.is_action_just_released("left_click"):
		var imp_vec = m_dir.rotated(PI) * 10
		if imp_vec.length() > max_impulse:
			imp_vec = imp_vec.normalized() * max_impulse
		first_touch = null
		$Line2D.visible = false
		apply_impulse(imp_vec)

	if Input.is_action_just_pressed("ui_accept"):
		get_tree().reload_current_scene()

	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()

func apply_impulse(imp_vec):
	$RigidBody2D.apply_impulse(Vector2.ZERO, imp_vec)
