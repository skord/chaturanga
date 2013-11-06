Meteor.subscribe('rooms')

Deps.autorun ->
  if Meteor.user()
    roomId = Meteor.user().profile.lastRoomId
    Meteor.subscribe "messages", roomId
    Meteor.subscribe "rosters", roomId

