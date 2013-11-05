Meteor.subscribe('rooms')

Deps.autorun ->
  if Meteor.user().profile
    roomId = Meteor.user().profile.lastRoomId
    Meteor.subscribe("messages", roomId)
