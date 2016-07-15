Images = new Mongo.Collection('images')

update_whitelist = ['rating']

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

  update: (userId, doc, fields) ->
    user = Meteor.users.findOne {_id: userId}
    # if user exists and just wants to give rating -> ALLOW
    if user and _.difference(fields, update_whitelist).length == 0
      return true
    # if user exists and document is owned by the user -> ALLOW
    if user and user._id == doc.created_by
      return true
    else
      return false

module.exports.Images = Images