Meteor.users.allow
  update: (userId, docs, fields, modifier) -> true

Meteor.setInterval ->
  Meteor.call 'removeOldConnections'
, 10000
