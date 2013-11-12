Template.main.currentRoomName = ->
  roomId = Meteor.user().profile.lastRoomId
  Rooms.findOne({_id: roomId}).name if roomId
