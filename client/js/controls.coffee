Template.controls.events "click #show-gravatars": ->
  Session.set "showGravatars", true

Template.controls.events "click #hide-gravatars": ->
  Session.set "showGravatars", false

Template.controls.gravatarsHidden = ->
  Session.equals 'showGravatars', false

Template.controls.count = ->
  count = @Messages.find().count()
  "#{count} messages"
