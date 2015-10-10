#Meteor.publish 'allTeams', ()->
  #Teams.find()

Meteor.onConnection (data)->
  team = Random.choice ["odd", "even"]
  Teams.insert {id:data.id, team: team}

Meteor.methods
  lastTeam: () ->
    team = Teams.find({}, {sort:{$natural: -1}}, limit:1).fetch()[0]
    console.log team.team
    team.team
