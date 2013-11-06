Meteor.subscribe('rooms')

Deps.autorun ->
  if Meteor.user()
    roomId = Meteor.user().profile.lastRoomId
    Meteor.subscribe "messages", roomId
    Meteor.subscribe "rosters", roomId
    Meteor.call 'addUserToRoster', roomId

    Meteor.setInterval ->
      Meteor.call 'keepalive', Meteor.userId()
    , 5000
