Meteor.subscribe('messages')

Meteor.startup ->
  Session.setDefault("showGravatars", true)
  $('h1').fitText()

