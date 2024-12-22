extends Node


##Stores signals meant to be used globally.

##Used by control nodes with a selected variable to set the selected variable of other nodes from the 
##same scene to false.
signal deselect_other_options(node : Node)
