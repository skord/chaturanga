Template.roster.list = ->
  roomId = Meteor.user().profile.lastRoomId
  Rooms.findOne({_id: roomId}).roster.join(', ')

Template.roster.invitees = ->
  roomId = Meteor.user().profile.lastRoomId
  Rooms.findOne({_id: roomId}).inviteeEmails.join(', ')

Template.roster.hasInvitees = ->
  roomId = Meteor.user().profile.lastRoomId
  Rooms.findOne({_id: roomId}).inviteeEmails
