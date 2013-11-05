Template.rooms.events 'click .nav-pills li': (e) ->
  e.preventDefault()
  roomId = $(e.target).data('id')
  Meteor.users.update({_id: Meteor.userId()}, {$set:{'profile.lastRoomId': roomId}})

Template.rooms.rooms = ->
  Rooms.find()

Template.rooms.helpers
  isActive: ->
    this._id is Meteor.user().profile.lastRoomId
