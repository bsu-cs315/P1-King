extends Node2D

enum GameState {
	Start,
	Play,
	Win,
	Lose
}

var CurrentGameState = GameState.Start

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	match CurrentGameState:
		GameState.Start:
			pass
		GameState.Play:
			pass
		GameState.Win:
			print("You Won!")
		GameState.Lose:
			print("You Lost!")
	pass
