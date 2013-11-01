Template.log.messages = ->
  @Messages.find()

Template.log.rendered = ->
  $('ul#messages').scrollTop($('ul#messages')[0].scrollHeight)
  $("time.timeago").timeago()

Template.log.messagesPresent = ->
  @Messages.find().count() > 0

Template.log.events "click #clear": ->
  Meteor.call 'removeAllMessages'

