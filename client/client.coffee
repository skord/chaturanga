Meteor.subscribe('rooms')
Meteor.subscribe('messages')

Meteor.startup ->
  $('h1').fitText()
