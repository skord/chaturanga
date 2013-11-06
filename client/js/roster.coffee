Template.roster.list = ->
  names = @Rosters.find().map (roster) -> roster.name
  names.join(', ')[0..-1]
