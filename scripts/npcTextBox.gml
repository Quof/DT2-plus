/*
This script is used for NPC characters.
It will create a text box from the associated character.
*/
with oMessageNPCchat
  instance_destroy()
messageWidth=string_width(stringToShow)
newMessage=instance_create(256-(messageWidth/2),48,oMessageNPCchat)
newMessage.message=stringToShow
newMessage.xPos=x
newMessage.yPos=y
newMessage.talker=talker
