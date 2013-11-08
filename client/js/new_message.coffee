Template.new_message.events
  'keypress input': (e) ->
    if e.keyCode is 13
      e.preventDefault()
      box = $(e.target)
      text = box.val()

      if text
        box.val('')
        userId   = Meteor.userId()
        email    = Meteor.user().emails[0].address
        time     = new Date().toISOString()
        gravatar = Gravatar.imageUrl(email)
        roomId   = Meteor.user().profile.lastRoomId

        Rooms.update({_id: roomId}, {$set: {lastMessage: new Date().getTime()}})

        Messages.insert({
          email:    email,
          gravatar: gravatar,
          roomId:   roomId,
          text:     text,
          time:     time,
          userId:   userId
        })
