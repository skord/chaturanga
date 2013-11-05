Template.main.roomSelected = ->
  Meteor.user() && Meteor.user().profile.lastRoomId
