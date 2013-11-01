Template.message.showGravatar = ->
  Session.equals('showGravatars', true)

Template.message.helpers
  parsedText: ->
    this.text.replace /(.*)(http:\/\/.*\.(gif|jpg|png|jpeg))(.*)/, "$1<img src='$2' />$4"
