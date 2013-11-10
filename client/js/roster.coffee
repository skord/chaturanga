Template.roster.list = ->
  roomId = Meteor.user().profile.lastRoomId
  Rooms.findOne({_id: roomId}).roster.join(', ')
