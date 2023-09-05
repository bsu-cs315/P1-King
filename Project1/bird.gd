extends RigidBody2D

enum BirdState{
	notThrown,
	thrown
}

var state = BirdState.notThrown

# Called when the node enters the scene tree for the first time.
func _ready():
	#mode = RigidBody2D
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if state == BirdState.thrown && linear_velocity <= Vector2(2,2):
		
		var t = Timer.new()
		t.set_wait_time(2)
		t.set_one_shot(true)
		self.add_child(t)
		t.start()
		await(t)
		queue_free()
	pass
	
	
	
func ThrowBird():
	#mode = RigidBody2D
	state = BirdState.thrown
	
	
