Template.controls.count = ->
  roomId = Meteor.user().profile.lastRoomId
  count = @Messages.find({roomId: roomId}).count()
  "#{count} messages"

Template.controls.messagesPresent = ->
  roomId = Meteor.user().profile.lastRoomId
  @Messages.find({roomId: roomId}).count() > 0
