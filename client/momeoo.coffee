#Meteor.subscribe 'allPeople'

Template.hello.helpers
  team: ()->
    ReactiveMethod.call 'lastTeam' #see meteor-reactive-method package


