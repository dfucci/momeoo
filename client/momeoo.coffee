Session.set 'voted', 'enabled'
Meteor.subscribe 'results'
Template.hello.helpers
  team: ()->
    team = ReactiveMethod.call 'lastTeam' #see meteor-reactive-method package
    Session.set 'team', team
    team

Template.buttons.helpers
  voted: () ->
    Session.get('voted')

Template.buttons.events
  'click .btn-success': (e, tpl)->
    e.preventDefault()
    tpl.$( "a:contains(#{e.toElement.innerText})" ).addClass('clicked')
    Session.set 'voted', 'disabled'
    Session.set 'vote', e.toElement.innerText
    vote =
      team: Session.get 'team'
      vote: e.toElement.innerText

    Meteor.call 'addVote', vote

Template.game.events
  'click .btn-warning': (e, tpl)->
    e.preventDefault()
    Meteor.call 'calculateResult'
    console.log 'callled'

Template.results.helpers
    result: ()->
      Results.find().fetch()[0]

    isWinner: () ->
      winner = Results.find().fetch()[0]["winner"]
      console.log winner
      message = if Session.get('team') == winner then "congratulations!" else "too bad :("
      message
