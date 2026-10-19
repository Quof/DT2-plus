/*
60fps change (added, from DT3+): room_goto for a room change with a transition. GameMaker's transitions last
transition_steps frames, so above 30fps they were 2x/4x as fast; the steps are scaled so the transition takes as long as
at 30fps. Only use it right after setting transition_steps (it scales whatever transition_steps is).
argument0: the room
*/
transition_steps = round(transition_steps / (gDeltaTime + 0.0001))
room_goto(argument0)
