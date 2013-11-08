Meteor.publish "rooms", ->
  Rooms.find({}, {sort: "name"})

Meteor.publish "rosters", (roomId) ->
  check roomId, String
  Rosters.find({roomId: roomId}, {sort: "email"})

Meteor.publish "messages", (roomId) ->
  check roomId, String
  [Rooms.find({_id: roomId}), Messages.find({roomId: roomId}, {sort: "time"})]

Meteor.publish "last_in_room", (roomId, userId) ->
  check userId, String
  [Rooms.find({_id: roomId}), LastInRoom.find({userId: userId})]

Meteor.users.allow
  update: (userId, docs, fields, modifier) -> true

Meteor.setInterval ->
  now = new Date().getTime()
  Rosters.remove({lastSeen: {$lt: (now - 10 * 1000)}})
, 10000

Meteor.methods
  removeAllMessages: (roomId) ->
    Messages.remove({roomId: roomId})

  setAllLastRoomId: (roomId) ->
    Meteor.users.update({}, {$set: {'profile.lastRoomId': roomId}}, {multi: true})

  addUserToRoster: (roomId) ->
    email      = Meteor.user().emails[0].address
    userId     = Meteor.userId()
    time       = new Date().getTime()
    prevRoomId = Meteor.user().profile.lastRoomId

    LastInRoom.remove({roomId: prevRoomId, userId: userId})
    LastInRoom.insert({roomId: prevRoomId, userId: userId, time: time})

    Meteor.users.update({_id: userId}, {$set:{'profile.lastRoomId': roomId}})

    Rosters.remove({userId: userId})
    Rosters.insert({roomId: roomId, userId: userId, email: email, lastSeen: time})

  keepalive: (userId) ->
    Rosters.update({userId: userId}, {$set: {lastSeen: (new Date()).getTime()}})

Meteor.startup ->
  unless Rooms.findOne()
    id = Rooms.insert({name: "Watercooler"})
    Rooms.insert({name: "Misc"})
    Meteor.call 'setAllLastRoomId', id

Accounts.onCreateUser (options, user) ->
  roomId = Rooms.findOne()._id
  user.profile = {lastRoomId: roomId}
  user

