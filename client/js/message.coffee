Template.message.showGravatar = ->
  Meteor.user().profile.showGravatars == true

Template.message.helpers
  parsedText: ->
    this.text.replace /(http:\/\/.*\.\w{3})/, "<a href='$1' target='_blank'>$1</a>"
