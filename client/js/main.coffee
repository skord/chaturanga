Template.main.roomSelected = ->
  Meteor.user() && Meteor.user().profile.lastRoomId

Template.main.currentRoomName = ->
  roomId = Meteor.user().profile.lastRoomId
  Rooms.findOne({_id: roomId}).name

Template.main.currentRoom = ->
  roomId = Meteor.user().profile.lastRoomId
  Rooms.findOne({_id: roomId})
