/*
Initializes the creation of a message box.
argument0: Message.
argument1: If 1: Set wait for input to true (used for cutscenes)
argument2: Message Type
argument3: Talker
argument4: Window Color
argument5: Window x Position
argument6: Window y Position
Note: If argument 5 or 6 = 0, then they will default to 32,48.
Note: If argument 5 = 1, then it will be set to the center of the screen.
*/
messageWidth=string_width(argument0)
if argument5=0
  argument5=32
else if argument5=1
{
  argument5=256-(messageWidth/2)
}
if argument6=0
  argument6=48
newMessage=instance_create(argument5,argument6,argument2)
newMessage.message=argument0
newMessage.talker=argument3
newMessage.window=argument4

if argument1=1
  bWaitForInput=true
