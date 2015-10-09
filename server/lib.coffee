Meteor.publish 'allPeople', ()->
  People.find()

Meteor.onConnection (data)->
  console.log data
  People.insert data
