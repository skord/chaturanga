Template.admin.messagesPresent = ->
  roomId = Meteor.user().profile.lastRoomId
  @Messages.find({roomId: roomId}).count() > 0

Template.admin.events
  'click a#admin-toggle': (e) ->
    e.preventDefault()
    $('ul#admin-menu').toggle()

  'click #clear-room': (e) ->
    e.preventDefault()
    roomId = Meteor.user().profile.lastRoomId
    Meteor.call 'removeAllMessages', roomId
