Meteor.subscribe('rooms')

Deps.autorun ->
  roomId = Meteor.user().profile.lastRoomId
  Meteor.subscribe("messages", roomId)
