Session.set 'voted', 'enabled'
Template.hello.helpers
  team: ()->
    ReactiveMethod.call 'lastTeam' #see meteor-reactive-method package

Template.buttons.helpers
  voted: () ->
    Session.get('voted')

Template.buttons.events
  'click .btn-success': (e, tpl)->
    e.preventDefault()
    console.log e
    console.log tpl
    console.log tpl.$( "a:contains(#{e.toElement.innerText})" ).addClass('clicked')
    Session.set 'voted', 'disabled'
    Session.set 'vote', e.toElement.innerText

