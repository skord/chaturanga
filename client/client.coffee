Deps.autorun ->
  if Meteor.user()
    roomId = Meteor.user().profile.lastRoomId
    email  = Meteor.user().emails[0].address
    Meteor.subscribe "connections", Meteor.userId()
    Meteor.subscribe "rooms", Meteor.userId(), email
    Meteor.subscribe "messages", roomId
    Meteor.subscribe "last_in_room", roomId, Meteor.userId()
    Meteor.call 'addUserToRoster', roomId

    Meteor.setInterval ->
      Meteor.call 'keepalive', Meteor.userId()
    , 5000
