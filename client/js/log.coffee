Template.log.messages = ->
  roomId = Meteor.user().profile.lastRoomId
  @Messages.find({roomId: roomId})

Template.log.rendered = ->
  $("time.timeago").timeago()
  $('ul#log').scrollTop($('ul#log')[0].scrollHeight)

Template.log.messagesPresent = ->
  roomId = Meteor.user().profile.lastRoomId
  @Messages.find({roomId: roomId}).count() > 0

Template.log.events "click #clear": ->
  roomId = Meteor.user().profile.lastRoomId
  Meteor.call 'removeAllMessages', roomId

