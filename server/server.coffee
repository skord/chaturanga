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
