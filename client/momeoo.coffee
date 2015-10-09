Session.setDefault 'counter', 0
Meteor.subscribe 'allPeople'

Template.hello.helpers
  counter: ()->
    People.find().count()

Template.hello.events
  'click button': () -> 
    Session.set 'counter', Session.get('counter') + 1


