/*
instance id fix (added): the instance that had id argument0 in the original game (noone if there's none), as in DT3+.
The original code refers to some instances placed in rooms by their ids (e.g. (341805).y), but this project gives room
instances new ids, so those numbers no longer find them. Each such instance registers itself under its original id
from its creation code (GID_SET), and the code that used the number uses GID(number) instead.
argument0: the instance's id in the original game
*/
if ds_map_exists(global.objectIDMap,argument0)
  return ds_map_find_value(global.objectIDMap,argument0)
return noone
