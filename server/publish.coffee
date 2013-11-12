Meteor.publish "connections", ->
  Connections.find({userId: this.userId})

Meteor.publish "rooms", (email) ->
  check email, String
  Rooms.find({$or: [
    {ownerId: this.userId},
    {inviteeEmails: {$in: [email]}}
  ]}, {sort: "name"})

Meteor.publish "messages", (roomId) ->
  check roomId, String
  [Rooms.find({_id: roomId}), Messages.find({roomId: roomId}, {sort: "time"})]

Meteor.publish "last_in_room", (roomId) ->
  check roomId, String
  [Rooms.find({_id: roomId}), LastInRoom.find({userId: this.userId})]
