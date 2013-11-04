Template.new_message.events "keypress input": (e) ->
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
      roomId   = Session.get('currentRoomId')

      Messages.insert({
        email:    email,
        gravatar: gravatar,
        roomId:   roomId,
        text:     text,
        time:     time,
        userId:   userId
      })
