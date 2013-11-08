Template.rooms.events
  'click .nav-pills li': (e) ->
    e.preventDefault()
    roomId = $(e.target).data('id')
    Meteor.call 'addUserToRoster', roomId

Template.rooms.rooms = ->
  Rooms.find()

Template.rooms.hasNewMessages = ->
  userId     = Meteor.userId()
  lastInRoom = LastInRoom.findOne({userId: userId, roomId: this._id})

  if lastInRoom
    this.lastMessage > lastInRoom.time

Template.rooms.helpers
  isActive: ->
    if Meteor.user().profile
      this._id is Meteor.user().profile.lastRoomId
