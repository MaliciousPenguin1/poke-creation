extends Node
class_name GameTime


enum DAY_NAMES {LUNDI, MARDI, MERCREDI, JEUDI, VENDREDI, SAMEDI, DIMANCHE}
enum MONTH_NAMES {JANVIER, FEVRIER, MARS, AVRIL, MAI, JUIN, JUILLET, AOUT, SEPTEMBRE, OCTOBRE, NOVEMBRE, DECEMBRE}


const DAY_NAMES_LABEL : Dictionary = {
	DAY_NAMES.LUNDI : "Lundi",
	DAY_NAMES.MARDI : "Mardi",
	DAY_NAMES.MERCREDI : "Mercredi",
	DAY_NAMES.JEUDI : "Jeudi",
	DAY_NAMES.VENDREDI : "Vendredi",
	DAY_NAMES.SAMEDI : "Samedi",
	DAY_NAMES.DIMANCHE : "Dimanche"
}

static var hours : String
static var minutes : String
static var month : MONTH_NAMES
static var month_name : String
static var day : DAY_NAMES
static var day_name : String
static var year : int


static func init() -> void:
	var current_time : Dictionary = Time.get_time_dict_from_system()
	hours = current_time["hour"]
	minutes = current_time["minutes"]
	pass
	
	
static func increment_time() -> void:
	pass
