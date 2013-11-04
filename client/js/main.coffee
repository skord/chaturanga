Template.main.roomSelected = ->
  Meteor.user() && Session.get('currentRoomId')
