Meteor.subscribe 'allPeople'

Template.hello.helpers
  counter: ()->
    People.find().count()



