/*
instance id fix (added): registers an instance under its id in the original game, for GID (as in DT3+). Called from the
creation code of the room instances that code refers to by id; each time the room starts, the entry is set again to the
new instance.
argument0: the instance's id in the original game
argument1: the instance (id)
*/
ds_map_delete(global.objectIDMap,argument0)
ds_map_add(global.objectIDMap,argument0,argument1)
