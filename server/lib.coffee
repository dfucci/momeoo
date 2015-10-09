Meteor.publish 'allPeople', ()->
  People.find()

Meteor.onConnection (data)->
  People.insert data
