extends RigidBody2D

enum BirdState{
	notThrown,
	thrown
}

var state = BirdState.notThrown
var mode
# Called when the node enters the scene tree for the first time.
func _ready():
	#mode = RigidBody2D.FREEZE_MODE_KINEMATIC
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if state == BirdState.thrown && linear_velocity <= Vector2(2,2):
		var t = Timer.new()
		t.set_wait_time(2)
		t.set_one_shot(true)
		self.add_child(t)
		t.start()
		await t.timeout
		var slingshot = get_tree().get_nodes_in_group("Slingshot")[0]
		slingshot.SlingShotState = slingshot.SlingState.reset
		queue_free()
	pass
	
	
	
func ThrowBird():
	#mode = RigidBody2D.DISABLE_MODE_MAKE_STATIC
	state = BirdState.thrown
	
	
