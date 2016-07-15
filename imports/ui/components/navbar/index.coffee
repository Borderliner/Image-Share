{ Template } = require 'meteor/templating'
require '../imageAddForm/index.coffee'
require './index.html'

Template.navbar.events
  'click .js-show-image-form': (event) ->
    $('#imageAddForm').modal('show')
    console.log 'Clicked!'