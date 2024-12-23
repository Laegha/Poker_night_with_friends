extends Control

enum loopTypes {NONE, REPEAT, BOUNCE}
@export var spriteSheet: Texture2D = null
@export var cellSize: Vector2 = Vector2(0, 0)
@export var loopType: loopTypes = loopTypes.NONE
@export var playOnStart: bool = true
@export var animDuration: float = .5

var cols: int
var rows: int
var style_box: StyleBoxTexture
var time_between_frames: float

func _ready() -> void:
	var width = spriteSheet.get_width()
	var height = spriteSheet.get_height()

	if width == 0 or height == 0:
		push_error("La textura no tiene dimensiones válidas.")
		return

	cols = int(width / cellSize.x)
	rows = int(height / cellSize.y)
	time_between_frames = animDuration / (cols * rows)
	style_box = $".".get_theme_stylebox("panel") as StyleBoxTexture
	if playOnStart:
		playAnimation()

func playAnimation():
	var currColumn: int = 0
	var currRow: int = 0
	var playingAnim: bool = true
	
	while playingAnim:
		style_box.region_rect = Rect2(currColumn * cellSize.x, currRow * cellSize.y, cellSize.x, cellSize.y)
		currColumn += 1
		if currColumn == cols:
			currColumn = 0
			currRow += 1
			if currRow == rows:
				playingAnim = false
				endAnimation()
		await get_tree().create_timer(time_between_frames).timeout

func endAnimation():
	if loopType == loopTypes.REPEAT:
		playAnimation()
	else: if loopType == loopTypes.BOUNCE:
		bounceAnimation()
		
func bounceAnimation():
	var currColumn: int = cols -2 #it is one less because we don't want to repeat the last frame
	var currRow: int = rows -1
	var playingAnim: bool = true
	
	while playingAnim:
		style_box.region_rect = Rect2(currColumn * cellSize.x, currRow * cellSize.y, cellSize.x, cellSize.y)
		currColumn -= 1
		if currColumn == 0:
			currColumn = cols -1
			currRow -= 1
			if currRow == 0:
				playingAnim = false
				playAnimation()
		await get_tree().create_timer(time_between_frames).timeout
