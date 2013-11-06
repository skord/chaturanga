Meteor.publish "rooms", ->
  Rooms.find()

Meteor.publish "rosters", (roomId) ->
  check roomId, String
  Rosters.find({roomId: roomId})

Meteor.publish "messages", (roomId) ->
  check roomId, String
  [Rooms.find({_id: roomId}), Messages.find({roomId: roomId})]

Meteor.users.allow
  update: (userId, docs, fields, modifier) -> true

Meteor.setInterval ->
  now = new Date().getTime()
  Rosters.remove({lastSeen: {$lt: (now - 10 * 1000)}})
, 10000

Meteor.startup ->
  Meteor.methods
    removeAllMessages: (roomId) ->
      Messages.remove({roomId: roomId})

    setAllLastRoomId: (roomId) ->
      Meteor.users.update({}, {$set: {'profile.lastRoomId': roomId}}, {multi: true})

    addUserToRoster: (roomId) ->
      email  = Meteor.user().emails[0].address
      userId = Meteor.userId()
      time   = new Date().getTime()

      Meteor.users.update({_id: userId}, {$set:{'profile.lastRoomId': roomId}})

      Rosters.remove({userId: userId})
      Rosters.insert({roomId: roomId, userId: userId, email: email, lastSeen: time})

    keepalive: (userId) ->
      Rosters.update({userId: userId}, {$set: {lastSeen: (new Date()).getTime()}})

  unless Rooms.findOne()
    id = Rooms.insert({name: "Watercooler"})
    Rooms.insert({name: "Misc"})
    Meteor.call 'setAllLastRoomId', id
