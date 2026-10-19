/*
input text change (added): what a [token] shows with the keyboard in use, brackets included ("[J]"), or "" if it isn't
an input token (scrInputCode). "[Down+Jump]" gives "[S]+[J]". As in DT3+.
argument0: the text between the brackets
*/
var n,c,p;
n=argument0
p=string_pos("+",n)
if p>0
{
  var tA,tB;
  tA=scrInputTokenKeys(string_copy(n,1,p-1))
  tB=scrInputTokenKeys(string_copy(n,p+1,string_length(n)-p))
  if tA="" or tB="" {return ""}
  return tA+"+"+tB
}
c=scrInputCode(n)
if c=-1 {return ""}
return "["+scrInputKeyName(c)+"]"
