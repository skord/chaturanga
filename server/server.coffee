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

Meteor.startup ->
  Meteor.methods
    removeAllMessages: (roomId) ->
      Messages.remove({roomId: roomId})

    setAllLastRoomId: (roomId) ->
      Meteor.users.update({}, {$set: {'profile.lastRoomId': roomId}}, {multi: true})

    addUserToRoster: (roomId) ->
      email = Meteor.user().emails[0].address
      Meteor.users.update({_id: Meteor.userId()}, {$set:{'profile.lastRoomId': roomId}})

      Rosters.remove({userId: Meteor.userId()})
      Rosters.insert({roomId: roomId, userId: Meteor.userId(), name: email})

  if Rooms.find().count() is 0
    id = Rooms.insert({name: "Watercooler"})
    Rooms.insert({name: "Misc"})
    Meteor.call 'setAllLastRoomId', id
