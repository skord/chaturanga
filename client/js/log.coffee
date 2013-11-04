Template.log.messages = ->
  @Messages.find({roomId: Session.get('currentRoomId')})

Template.log.rendered = ->
  $('ul#log').scrollTop($('ul#log')[0].scrollHeight)
  $("time.timeago").timeago()

Template.log.messagesPresent = ->
  @Messages.find({roomId: Session.get('currentRoomId')}).count() > 0

Template.log.events "click #clear": ->
  Meteor.call 'removeAllMessages'

