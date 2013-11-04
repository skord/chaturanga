Template.rooms.events 'click a#toggle-rooms': (e) ->
  e.preventDefault()
  # Rooms.insert({name: 'Watercooler'})
  $('ul.dropdown-menu').toggle()

Template.rooms.events 'click ul.dropdown-menu a': (e) ->
  e.preventDefault()
  Session.set 'currentRoomId', $(e.target).data('id')
  $('ul.dropdown-menu').toggle()

Template.rooms.rooms = ->
  Rooms.find()

Template.rooms.currentRoomName = ->
  if Session.get('currentRoomId')
    Rooms.findOne({_id: Session.get('currentRoomId')}).name

