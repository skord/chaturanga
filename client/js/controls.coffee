Template.controls.events "click #show-gravatars": ->
  Meteor.users.update({_id: Meteor.userId()}, {$set:{'profile.showGravatars': true}})

Template.controls.events "click #hide-gravatars": ->
  Meteor.users.update({_id: Meteor.userId()}, {$set:{'profile.showGravatars': false}})

Template.controls.events "click #clear": (e) ->
  e.preventDefault()
  roomId = Meteor.user().profile.lastRoomId
  Meteor.call 'removeAllMessages', roomId

Template.controls.gravatarsHidden = ->
  Meteor.user().profile.showGravatars == false

Template.controls.messagesPresent = ->
  roomId = Meteor.user().profile.lastRoomId
  @Messages.find({roomId: roomId}).count() > 0

Template.controls.count = ->
  roomId = Meteor.user().profile.lastRoomId
  count = @Messages.find({roomId: roomId}).count()
  "#{count} messages"
