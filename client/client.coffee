Deps.autorun ->
  if Meteor.user()
    roomId = Meteor.user().profile.lastRoomId
    Meteor.subscribe "connections", Meteor.userId()
    Meteor.subscribe "rooms", Meteor.userId()
    Meteor.subscribe "messages", roomId
    Meteor.subscribe "last_in_room", roomId, Meteor.userId()
    Meteor.call 'addUserToRoster', roomId

    Meteor.setInterval ->
      Meteor.call 'keepalive', Meteor.userId()
    , 5000

Meteor.startup ->
  unless Rooms.findOne()
    userId = Meteor.userId()
    roomId = Rooms.insert({name: "Watercooler", ownerId: userId})
    Meteor.users.update({_id: userId}, {$set:{'profile.lastRoomId': roomId}})
