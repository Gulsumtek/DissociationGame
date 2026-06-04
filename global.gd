extends Node

# Karakterin hangi kapıdan geçiş yaptığını aklında tutacak değişken
var entrance_name : String = ""
var soul_fragments_collected: int = 0
var collected_fragment_ids: Array = [] # Toplanan parçaların ID listesi
var soul_fragments_dropped: int = 0
var dropped_fragment_ids: Array = []
# global.gd'ye ekle
var came_from_soul: bool = false
var blackboard_drawn: bool = false
var park_cutscene_finished: bool = false 

var alarm_triggered: bool = false
var cafe_lights_on: bool = false
var cafe_soul_done: bool = false
var cafe_cutscene1_done: bool = false
var enter_cafe_as_soul: bool = false
var cafe_cutscene2_done: bool = false
