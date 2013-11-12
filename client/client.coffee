Deps.autorun ->
  if Meteor.userId()
    user   = Meteor.user()
    userId = Meteor.userId()
    email  = user.emails[0].address

    Meteor.subscribe "rooms", email

    if user.profile is undefined
      if Rooms.findOne() is undefined
        roomId = Rooms.insert({name: "Watercooler", ownerId: userId, inviteeEmails: [], roster: []})
      else
        roomId = Rooms.findOne()._id

      Meteor.users.update({_id: userId}, {$set:{'profile.lastRoomId': roomId, 'profile.showGravatars': true}})
    else
      roomId = user.profile.lastRoomId

    Meteor.subscribe "connections"
    Meteor.subscribe "messages", roomId
    Meteor.subscribe "last_in_room", roomId
    Meteor.call 'addUserToRoster', roomId

    Meteor.setInterval ->
      Meteor.call 'keepalive', userId
    , 5000
