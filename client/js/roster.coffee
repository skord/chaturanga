Template.roster.list = ->
  emails = @Rosters.find().map (roster) -> roster.email
  emails.join(', ')[0..-1]
