Template.main.roomSelected = ->
  Meteor.user() && Meteor.user().profile.lastRoomId

Template.main.currentRoomName = ->
  if Meteor.user().profile
    roomId = Meteor.user().profile.lastRoomId
    Rooms.findOne({_id: roomId}).name if roomId

Template.main.currentRoom = ->
  roomId = Meteor.user().profile.lastRoomId
  Rooms.findOne({_id: roomId})
