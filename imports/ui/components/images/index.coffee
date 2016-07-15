{ Template } = require 'meteor/templating'
{ Images } = require '/lib/collections/images.coffee'
require './index.html'

imageLimit = new ReactiveVar(8)

$(window).on 'scroll', (event) ->
  if ($(window).scrollTop() + $(window).height()) > ($(document).height() - 100)
    imageLimit.set imageLimit.get() + 4

Template.images.onCreated ->
  @userFilter = new ReactiveVar()

Template.images.helpers
  images: ->
    userFilter = Template.instance().userFilter.get()
    
    if userFilter
      Images.find {created_by: (Meteor.users.findOne username: userFilter)._id},
        sort:
          created_at: -1
          rating: -1
        limit: imageLimit.get()
    else
      Images.find {},
        sort:
          created_at: -1
          rating: -1
        limit: imageLimit.get()
  
  isFiltered: ->
    userFilter = Template.instance().userFilter.get()
    if userFilter
      return true
    else
      return false

  canDelete: ->
    if Meteor.user() and this
      if Meteor.user()._id == this.created_by
        return true
      else
        return false

  getUserById: (user_id) ->
    user = Meteor.users.find
      _id: user_id
    
    return user.fetch()[0].username

Template.images.events
  
  'click .js-del-image': (event) ->
    image_id = this._id
    $('#' + image_id).hide 'slow', -> #When done hiding from UI, remove the real image from DB
      Images.remove
        '_id': image_id
  
  'click .js-rate-image': (event) ->
    rating = $(event.currentTarget).data('userrating')
    image_id = this.id
    Images.update { _id: image_id },
      $set:
        rating: rating
    
  'click .js-show-image-form': (event) ->
    $('#image_add_form').modal('show')

  'click .js-set-image-filter': (event, template) ->
    username = event.target.text
    template.userFilter.set(username)

  'click .js-clear-image-filter': (event, template) ->
    template.userFilter.set(undefined)
    
