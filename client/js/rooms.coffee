Template.rooms.events 'click .nav-pills li': (e) ->
  e.preventDefault()
  roomId = $(e.target).data('id')
  Meteor.call 'addUserToRoster', roomId

Template.rooms.rooms = ->
  Rooms.find()

Template.rooms.helpers
  isActive: ->
    if Meteor.user().profile
      this._id is Meteor.user().profile.lastRoomId
