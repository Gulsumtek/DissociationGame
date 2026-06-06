extends Node
var current_soul_speed: float = 180.0
var is_soul_mode: bool = false
# Karakterin hangi kapıdan geçiş yaptığını aklında tutacak değişken
var entrance_name : String = ""
var soul_fragments_collected: int = 0
var collected_fragment_ids: Array = [] # Toplanan parçaların ID listesi
var soul_fragments_dropped: int = 0
var dropped_fragment_ids: Array = []
var soul_phase_complete: bool = false  # Ruh fazı tamamlandı, parçalar toplanabilir
# global.gd'ye ekle
var came_from_soul: bool = false
var blackboard_drawn: bool = false
var park_cutscene_finished: bool = false 

var cafe_completed: bool = false
var alarm_triggered: bool = false
var cafe_lights_on: bool = false
var cafe_soul_done: bool = false
var cafe_cutscene1_done: bool = false
var enter_cafe_as_soul: bool = false
var cafe_cutscene2_done: bool = false
