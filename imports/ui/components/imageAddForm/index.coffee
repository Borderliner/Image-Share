{ Template } = require 'meteor/templating'
{ Images } = require '/lib/collections/images.coffee'
require './index.html'

Template.imageAddForm.events
  'submit .js-add-image': (event) ->
    event.preventDefault()
    filename = event.target[0].files[0].name
    img_src = if filename then filename else img_src_url
    img_label = event.target.img_label.value
    img_alt = img_label
    img_desc = event.target.img_desc.value

    if Meteor.user()
      Images.insert
        img_src: img_src
        img_label: img_label
        img_desc: img_desc
        img_alt: img_alt
        created_at: new Date()
        created_by: Meteor.user()._id
    
    $('#imageAddForm').modal('hide')

