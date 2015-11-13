
alphabet0 = 'ᐁᐂᐃᐄᐅᐆᐇᐈᐉᐊᐋᐌᐍᐎᐏᐐᐑᐒᐓ⊟ᐔᐕᐖᐗᐘᐙᐚᐛᐜᐝᐞᐟ⋇⋈⋉⋊⋋⋌⊏⊐'
alphabet1 = 'abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLMNOPQRSTUVWXYZ'


exports.encrypt = (string) ->
  result = ''
  for char in string
    index = alphabet1.indexOf char
    if index is -1
      result += char
    else
      result += alphabet0[index]

  return result


exports.decrypt = (string) ->
  result = ''
  for char in string
    index = alphabet0.indexOf char
    if index is -1
      result += char
    else
      result += alphabet1[index]

  return result
