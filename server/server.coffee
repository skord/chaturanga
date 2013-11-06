Meteor.publish "rooms", ->
  Rooms.find()

Meteor.publish "messages", (roomId) ->
  check roomId, String
  [Rooms.find({_id: roomId}), Messages.find({roomId: roomId})]

Meteor.users.allow
  update: (userId, docs, fields, modifier) -> true

Meteor.startup ->
  Meteor.methods
    removeAllMessages: (roomId) ->
      Messages.remove({roomId: roomId})

    setAllLastRoomId: (roomId) ->
      Meteor.users.update({}, {$set: {'profile.lastRoomId': roomId}}, {multi: true})

  if Rooms.find().count() is 0
    id = Rooms.insert({name: "Watercooler"})
    Meteor.call 'setAllLastRoomId', id
