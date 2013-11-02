Template.controls.events "click #show-gravatars": ->
  Meteor.users.update({_id: Meteor.userId()}, {$set:{'profile.showGravatars': true}})

Template.controls.events "click #hide-gravatars": ->
  Meteor.users.update({_id: Meteor.userId()}, {$set:{'profile.showGravatars': false}})

Template.controls.gravatarsHidden = ->
  Meteor.user().profile.showGravatars == false

Template.controls.messagesPresent = ->
  @Messages.find().count() > 0

Template.controls.count = ->
  count = @Messages.find().count()
  "#{count} messages"
