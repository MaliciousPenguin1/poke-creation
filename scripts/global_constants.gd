extends Node
class_name GlobalConstants


##Used to store various constants used in your project.


#======================================================
#OVERWORLD
#======================================================
##The size of the tiles used in your tilesets. Used in code related to movements.
const TILES_SIZE : int = 16
##The speed at which the player and some interactables move.
const WALKING_SPEED : int = 100
##The speed at which the player and some interactables run.
const RUNNING_SPEED : int = 200
##The delay before transitionning from Turning to Walking
const DELAY_BEFORE_WALKING : float = 0.2
##The Camera zoom
const CAMERA_ZOOM : int = 2
##Chunk size
const CHUNK_SIZE : int = 40
##NB of neighbour chunks to render
const CHUNK_RENDREING_DISTANCE : int = 1

#======================================================
#POKEMON
#======================================================
##The maximum level that can be reached by a Pokémon.
const MAX_LEVEL : int = 100


#======================================================
#OTHER
#======================================================
##The maximum amount of a singular item that can be held in a bag.
const MAX_ITEM_QUANTITY : int = 999
##The max Trainer Id number for the player
const MAX_TRAINER_ID : int = 65535
##The cooldown between keyboard inputs ofr GUI (ex: keep up pressed to scroll a list)
const UI_KEYBOARD_COOLDOWN : float = 0.1


#======================================================
#ENUM
#======================================================
#The gender for the player
enum PlayerGender {MALE, FEMALE}
