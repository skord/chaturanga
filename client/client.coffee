Meteor.subscribe('rooms')

Deps.autorun ->
  if Meteor.user()
    roomId = Meteor.user().profile.lastRoomId
    Meteor.subscribe "messages", roomId
    Meteor.subscribe "rosters", roomId
    Meteor.subscribe "last_in_room", roomId, Meteor.userId()
    Meteor.call 'addUserToRoster', roomId

    Meteor.setInterval ->
      Meteor.call 'keepalive', Meteor.userId()
    , 5000
