Template.rooms.events 'click a#toggle-rooms': (e) ->
  e.preventDefault()
  # Rooms.insert({name: 'Watercooler'})
  $('ul.dropdown-menu').toggle()

Template.rooms.events 'click ul.dropdown-menu a': (e) ->
  e.preventDefault()
  console.log $(e.target).data('id')

Template.rooms.rooms = ->
  Rooms.find()
