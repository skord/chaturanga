Meteor.publish "rooms", ->
  Rooms.find()

Meteor.publish "messages", ->
  roomId = Meteor.user().profile.lastRoomId
  Messages.find({roomId: roomId})

Meteor.users.allow
  update: (userId, docs, fields, modifier) ->
      return true

Meteor.startup ->
  Meteor.methods
    removeAllMessages: (roomId) ->
      Messages.remove({roomId: roomId})
