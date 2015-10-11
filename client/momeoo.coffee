Session.set 'voted', 'enabled'
Meteor.subscribe 'results'
#countdown = new ReactiveCountdown(10)
#countdown.start()

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

#Template.game.events
  #'click .btn-warning': (e, tpl)->
    #e.preventDefault()
    #Meteor.call 'calculateResult'

#Template.game.helpers
    #getCountdown: ()->
      #console.log countdown
      #countdown.get()

Template.results.helpers
    result: ()->
      res = Results.find({}, {sort:{createdAt: -1}}, limit: 1).fetch()[0]
      console.log res
      res

    isWinner: () ->
      result = Results.find({}, {sort:{createdAt: -1}}, limit: 1).fetch()[0]
      if result? and result.odd.result? and result.even.result?
        message = "The winner is #{result.winner.toUpperCase()}"
        message += if Session.get('team') == result.winner then " congratulations!" else " too bad :("
      else message = "Waiting for votes..."
      message
