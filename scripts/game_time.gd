extends Node2D
class_name GameTime


enum DAY_NAMES {LUNIA, MERIA, YARIA, GWENIA, SADIA, SULIA}
enum MONTH_NAMES {FLORALIS, SOLIOS, BRUMAL, HIVRUS}


const DAY_NAMES_LABEL : Dictionary = {
	DAY_NAMES.LUNIA : "Lunia",
	DAY_NAMES.MERIA : "Meria",
	DAY_NAMES.YARIA : "Yaria",
	DAY_NAMES.GWENIA : "Gwenia",
	DAY_NAMES.SADIA : "Sadia",
	DAY_NAMES.SULIA : "Sulia",
}
const MONTH_NAMES_LABEL : Dictionary = {
	MONTH_NAMES.FLORALIS : "Floralis",
	MONTH_NAMES.SOLIOS : "Solios",
	MONTH_NAMES.BRUMAL : "Brumal",
	MONTH_NAMES.HIVRUS : "Hivrus",
}
const IRL_FRAME_PER_IG_MIN : int = 120
const MAX_MINUTES : int = 60
const MAX_HOURS : int = 24
const MAX_DAY : int = 30
const MAX_MONTH : int = 4


static var hour : int
static var minute : int
static var month : int
static var day : int
static var year : int


var nb_frames_passed_since_last_update : int


func _ready() -> void:
	init()
	#stop_clock()


func _process(_delta: float) -> void:
	nb_frames_passed_since_last_update += 1
	if nb_frames_passed_since_last_update == IRL_FRAME_PER_IG_MIN:
		increment_time()
		nb_frames_passed_since_last_update = 0


func init() -> void:
	hour = 19
	minute = 0
	day = 0
	month = 1
	year = 500

	nb_frames_passed_since_last_update = 0


static func increment_time() -> void:
	increment_minute(1)
	print(get_formatted_current_time())


static func increment_minute(increment : int = 1) -> void:
	minute += increment
	if minute >= MAX_MINUTES:
		var hours_to_increment = minute / MAX_MINUTES
		minute %= MAX_MINUTES
		increment_hour(hours_to_increment)


static func increment_hour(increment : int = 1) -> void:
	hour += increment
	if hour >= MAX_HOURS:
		var days_to_increment = hour / MAX_HOURS
		hour %= MAX_HOURS
		increment_day(days_to_increment)


static func increment_day(increment : int = 1) -> void:
	day += increment
	if day >= MAX_DAY:
		var months_to_increment = day / MAX_DAY
		day %= MAX_DAY
		increment_month(months_to_increment)


static func increment_month(increment : int = 1) -> void:
	month += increment
	if month >= MAX_MONTH:
		var years_to_increment = month / MAX_MONTH
		month %= MAX_MONTH
		increment_year(years_to_increment)


static func increment_year(increment : int = 1) -> void:
	year += increment


func start_clock() -> void:
	set_process(true)


func stop_clock() -> void:
	set_process(false)


static func get_formatted_current_date() -> String:
	var day_label : String = DAY_NAMES_LABEL[day  % MAX_DAY]
	var month_label : String = MONTH_NAMES_LABEL[month  % MAX_MONTH]
	
	return day_label + " " + str(day + 1) + " " + month_label + " " + str(year)


static func get_formatted_current_time() -> String:
	return "%02d" % hour + ":" + "%02d" % minute
