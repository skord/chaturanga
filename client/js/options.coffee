Template.options.gravatarsHidden = ->
  Meteor.user().profile.showGravatars is false

Template.options.messagesPresent = ->
  roomId = Meteor.user().profile.lastRoomId
  @Messages.find({roomId: roomId}).count() > 0

Template.options.helpers
  isOwner: ->
    roomId = Meteor.user().profile.lastRoomId
    room   = Rooms.findOne({_id: roomId})
    room.ownerId && room.ownerId is Meteor.userId()

Template.options.events
  'click a#options-toggle': (e) ->
    e.preventDefault()
    $('ul#options-menu').toggle()

  'click #show-gravatars': (e) ->
    e.preventDefault()
    Meteor.users.update({_id: Meteor.userId()}, {$set:{'profile.showGravatars': true}})

  'click #hide-gravatars': (e) ->
    e.preventDefault()
    Meteor.users.update({_id: Meteor.userId()}, {$set:{'profile.showGravatars': false}})

  'click #create-room': (e) ->
    e.preventDefault()
    Rooms.insert({name: "New Room", ownerId: Meteor.userId()})

  'click #rename-room': (e) ->
    e.preventDefault()
    roomId = Meteor.user().profile.lastRoomId
    a = $("a[data-id='#{roomId}']")
    a.attr('contenteditable', true)

  'click #delete-messages': (e) ->
    e.preventDefault()
    roomId = Meteor.user().profile.lastRoomId
    Meteor.call 'removeAllMessages', roomId

  'click #delete-room': (e) ->
    e.preventDefault()
    roomId = Meteor.user().profile.lastRoomId
    Rooms.remove({_id: roomId})
    Meteor.call 'removeAllMessages', roomId
    newLastRoomId = Rooms.findOne()._id
    Meteor.users.update({_id: Meteor.userId()}, {$set:{'profile.lastRoomId': newLastRoomId}})

  'click #invite-someone': (e) ->
    e.preventDefault()
    ownerId   = Meteor.userId()
    inviteeId = "ASDF"
    roomId    = Meteor.user().profile.lastRoomId
    Rooms.update({_id: roomId}, {$push: {inviteeIds: inviteeId}})
