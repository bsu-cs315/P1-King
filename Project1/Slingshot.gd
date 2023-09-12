extends Node2D


enum SlingState{
	idle,
	pulling,
	birdThrown,
	reset
}


var SlingShotState
var LeftLine
var RightLine
var Player
var CenterOfSlingshot
var pullling = false

# Called when the node enters the scene tree for the first time.
func _ready():
	SlingShotState = SlingState.idle
	LeftLine = $LeftLine
	RightLine = $RightLine
	CenterOfSlingshot = $CenterOfSlingshot.position
	LeftLine.points[1] = CenterOfSlingshot
	RightLine.points[1] = CenterOfSlingshot
	var player = get_tree().get_nodes_in_group("Player")[0]
	player.position = CenterOfSlingshot
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	match SlingShotState:
		SlingState.idle:
			pass
		SlingState.pulling:
			var player = get_tree().get_nodes_in_group("Player")[0]
			if Input.is_action_pressed("Left_Mouse"):
				var distance = get_global_mouse_position()
				if distance.distance_to(CenterOfSlingshot) > 100:
					distance = (distance - CenterOfSlingshot).normalized() * 100 + $CenterOfSlingshot.position
				player.position = distance
				LeftLine.points[1] = distance
				RightLine.points[1] = distance
				var velocity = CenterOfSlingshot - distance
				var actVelocity = velocity/20 * distance
				var pointPosition = CenterOfSlingshot
				$ShotArc.clear_points()
				for i in 5000:
					$ShotArc.add_point(pointPosition)
					actVelocity.y += 150 * delta * -1
					pointPosition += actVelocity * delta * -1
					if pointPosition.y > $ShotArc.position.y:
						break
						
			else:
				$ShotArc.clear_points()
				var distance = get_global_mouse_position()
				if distance.distance_to(CenterOfSlingshot) > 100:
					distance = (distance - CenterOfSlingshot).normalized() * 100 + $CenterOfSlingshot.position
				var velocity = CenterOfSlingshot - distance
				
				player.ThrowBird()
				player = player as RigidBody2D
				player.apply_impulse(Vector2(), (velocity/20 * distance) * -1)
				SlingShotState = SlingState.birdThrown
				LeftLine.points[1] = CenterOfSlingshot
				RightLine.points[1] = CenterOfSlingshot
				GameManager.CurrentGameState = GameManager.GameState.Play
				get_tree().get_nodes_in_group("Camera")[0].followingPlayer = true
		SlingState.birdThrown:
			pass
		SlingState.reset:
			var lives = get_tree().get_nodes_in_group("Player")
			if lives.size() > 0:
				Player = lives[0] as RigidBody2D
				var Tween = create_tween()
				Tween.interpolate_property(Player, Player.position, Vector2(.5, .5), 1.5).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)
				Tween.start()
				if(Player.global_position - CenterOfSlingshot).length() < 0.1:
					SlingShotState = SlingState.idle
				pass
	pass


func _on_touch_area_input_event(viewport, event, shape_idx):
	if SlingShotState == SlingState.idle:
		if(event is InputEventMouseButton && event.pressed):
			SlingShotState = SlingState.pulling
	pass # Replace with function body.
