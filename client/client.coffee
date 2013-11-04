Meteor.subscribe('rooms')

Deps.autorun ->
  Meteor.subscribe("messages", {roomId: Session.get("currentRoomId")})

Meteor.startup ->
  $('h1').fitText()
