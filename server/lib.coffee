#Meteor.publish 'allTeams', ()->
  #Teams.find()

Meteor.onConnection (data)->
  team = Random.choice ["odd", "even"]
  Teams.insert {id:data.id, team: team}

Meteor.methods
  lastTeam: () ->
    team = Teams.find({}, {limit:1}, {sort:{$natural: -1}}).fetch()[0]
    console.log team.team
    team.team
