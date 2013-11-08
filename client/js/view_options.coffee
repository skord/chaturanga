Template.view_options.events 'click a#options-toggle': (e) ->
  e.preventDefault()
  $('ul#options-menu').toggle()

Template.view_options.events "click #show-gravatars": ->
  Meteor.users.update({_id: Meteor.userId()}, {$set:{'profile.showGravatars': true}})

Template.view_options.events "click #hide-gravatars": ->
  Meteor.users.update({_id: Meteor.userId()}, {$set:{'profile.showGravatars': false}})

Template.view_options.gravatarsHidden = ->
  Meteor.user().profile.showGravatars == false

