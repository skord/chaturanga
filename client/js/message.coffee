Template.message.events 'click a.delete': (e) =>
  e.preventDefault()
  messageId = $(e.target).data('id')
  @Messages.remove({_id: messageId})

Template.message.showGravatar = ->
  Meteor.user().profile.showGravatars == true

Template.message.helpers
  parsedText: ->
    this.text.replace /(http:\/\/.*\.\w{3})/, "<a href='$1' target='_blank'>$1</a>"

  isDeletable: ->
    this.userId is Meteor.userId()
