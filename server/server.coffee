Meteor.publish "rooms", ->
  Rooms.find()

Meteor.publish "messages", ->
  Messages.find()

Meteor.users.allow
  update: (userId, docs, fields, modifier) ->
      return true

Meteor.startup ->
  Meteor.methods
    removeAllMessages: (roomId) ->
      Messages.remove({roomId: roomId})
