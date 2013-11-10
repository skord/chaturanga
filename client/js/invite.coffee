Template.invite.visible = ->
  Session.get('inviteSliderVisible')

Template.invite.events
  'click #send-invites': (e) ->
    e.preventDefault()
    textarea = $('textarea#invitee-addresses')
    emails   = textarea.val().split(/\n/)
    roomId   = Meteor.user().profile.lastRoomId

    if emails.length
      textarea.val('')
      Session.set('inviteSliderVisible', false)
      Rooms.update({_id: roomId}, {$push: {inviteeEmails: {$each: emails}}})

  'click #close-invites': (e) ->
    $('textarea#invitee-addresses').val('')
    Session.set('inviteSliderVisible', false)

