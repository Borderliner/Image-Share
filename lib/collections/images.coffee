Images = new Mongo.Collection('images')

Images.allow
  insert: (userId, doc) ->
    user = Meteor.users.findOne {_id: userId}
    if user
      return true
    else
      return false

  remove: (userId, doc) ->
    user = Meteor.users.findOne {_id: userId}
    if user and user._id == doc.created_by
      return true
    else
      return false

  update: (userId, doc) ->
    user = Meteor.users.findOne {_id: userId}
    if user and user._id == doc.created_by
      return true
    else
      return false

module.exports.Images = Images