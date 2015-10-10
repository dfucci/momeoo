Meteor.publish 'results', ()->
  Results.find({}, {sort:{$natural: -1}}, limit: 1)

Meteor.onConnection (data)->
  team = Random.choice ["odd", "even"]
  Teams.insert {id:data.id, team: team}

Meteor.methods
  lastTeam: () ->
    team = Teams.find({}, {sort:{$natural: -1}}, limit:1).fetch()[0]
    team.team

  addVote: (vote)->
    Votes.insert vote

  calculateResult: ()->
    even = Votes.find({team: 'even'}).fetch()
    odd = Votes.find({team: 'odd'}).fetch()
    cEven = _.countBy even, 'vote'
    cOdd = _.countBy odd, 'vote'
    maxOdd = _.max cOdd
    maxEven = _.max cEven
    resultOdd = _.invert(cOdd)[maxOdd]
    resultEven = _.invert(cEven)[maxEven]
    result =parseInt(resultEven) + parseInt(resultOdd)
    winner = if result % 2 then "odd" else "even"
    resultWinner =
      winner: winner
      odd:
        result: resultOdd
        votes: maxOdd
      even:
        result: resultEven
        votes: maxEven

    Results.insert resultWinner
