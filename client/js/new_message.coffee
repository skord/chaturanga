Template.new_message.events "keypress input": (e) ->
  if e.keyCode is 13
    box = $(e.target)
    text = box.val()

    if text
      box.val('')
      userId   = Meteor.userId()
      email    = Meteor.user().emails[0].address
      time     = new Date().toISOString()
      gravatar = Gravatar.imageUrl(email)

      Messages.insert({
        text:     text,
        email:    email,
        time:     time,
        userId:   userId,
        gravatar: gravatar
      })
