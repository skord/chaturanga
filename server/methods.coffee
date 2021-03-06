Meteor.methods
  removeOldConnections: ->
    now         = new Date().getTime()
    connections = Connections.find({lastSeen: {$lt: (now - 10 * 1000)}})

    connections.forEach (conn) ->
      user   = Meteor.users.findOne({_id: conn.userId})
      email  = user.emails[0].address
      roomId = user.profile.lastRoomId
      Rooms.update({_id: roomId}, {$pull: {roster: email}})

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

    Rooms.update({_id: prevRoomId}, {$pull: {roster: email}})
    Rooms.update({_id: roomId}, {$push: {roster: email}})

    Connections.remove({userId: userId})
    Connections.insert({userId: userId, lastSeen: (new Date()).getTime()})

  keepalive: (userId) ->
    Connections.update({userId: userId}, {$set: {lastSeen: (new Date()).getTime()}})

  sendInvite: (to) ->
    check(to, String)
    this.unblock()
    Email.send({
      to: to,
      from: "system@chaturan.ga",
      subject: "You've been invited!",
      text: "You've been invited to Chaturan.ga!
        It's a place to quickly chat with whoever.
        It's free. Just create an account on http://chaturan.ga to start!"
    })

