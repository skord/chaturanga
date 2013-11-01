Meteor.publish "messages", ->
  Messages.find()

Meteor.startup ->
  Meteor.methods
    removeAllMessages: ->
      Messages.remove({})
