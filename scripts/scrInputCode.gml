/*
input text change (added): the input a [token] in a text stands for, or -1 if it isn't one (as in DT3+). Texts name
inputs with tokens like [Jump] or [Confirm]; when drawn they show the key it's set to ([J]) or, while the gamepad is
the input being used (global.gpLastUsed), its button's icon (scrInputText, scrDrawInput). The codes are the gamepad
actions (scrGamepadInit):
  1-11 [Left] [Right] [Up] [Down] [Jump] [Fire] [Water] [Wind] [Earth] [Dash Left] [Dash Right]: Set Controls' keys
  12 [Pause] (P / START; on the title screen it also goes to the Extras Room), 13 [Skip] (M / BACK),
  14 [Confirm] (J / A), 15 [Cancel] (K / B), 16 [Swap Lists] (Set Controls' L / Y)
  103-104 [Menu Up] [Menu Down]: the title screen's W / S (on a gamepad, Up / Down's buttons)
argument0: the text between the brackets
*/
var n;
n=argument0
if n="Left" {return 1}
if n="Right" {return 2}
if n="Up" {return 3}
if n="Down" {return 4}
if n="Jump" {return 5}
if n="Fire" {return 6}
if n="Water" {return 7}
if n="Wind" {return 8}
if n="Earth" {return 9}
if n="Dash Left" {return 10}
if n="Dash Right" {return 11}
if n="Pause" {return 12}
if n="Skip" {return 13}
if n="Confirm" {return 14}
if n="Cancel" {return 15}
if n="Swap Lists" {return 16}
if n="Menu Up" {return 103}
if n="Menu Down" {return 104}
return -1
