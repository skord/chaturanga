Template.rooms.events 'click a#toggle-rooms': (e) ->
  e.preventDefault()
  # Rooms.insert({name: 'Watercooler'})
  $('ul.dropdown-menu').toggle()

Template.rooms.events 'click ul.dropdown-menu a': (e) ->
  e.preventDefault()
  roomId = $(e.target).data('id')
  Meteor.users.update({_id: Meteor.userId()}, {$set:{'profile.lastRoomId': roomId}})
  $('ul.dropdown-menu').toggle()

Template.rooms.events 'click a#leave-room': (e) ->
  e.preventDefault()
  Meteor.users.update({_id: Meteor.userId()}, {$set:{'profile.lastRoomId': null}})

Template.rooms.rooms = ->
  Rooms.find()

Template.rooms.currentRoomName = ->
  roomId = Meteor.user().profile.lastRoomId

  if roomId
    Rooms.findOne({_id: roomId}).name

