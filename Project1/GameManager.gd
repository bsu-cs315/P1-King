extends Node2D

enum GameState {
	Start,
	Play,
	Win,
	Lose
}

var CurrentGameState = GameState.Start
var Score = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	get_tree().get_nodes_in_group("InterfaceController")[0].SetScore()
	match CurrentGameState:
		GameState.Start:
			pass
		GameState.Play:
			var birds = get_tree().get_nodes_in_group("Bird")
			if birds.size() <=0:
				CurrentGameState = GameState.Lose
			pass
		GameState.Win:
			print("You Won!")
		GameState.Lose:
			print("You Lost!")
	pass
