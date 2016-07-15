{ Meteor } = require 'meteor/meteor'
{ Mongo } = require 'meteor/mongo'
{ Images } = require '/lib/collections/images.coffee'

if Images.find().count() == 0

#> Insert 22 Images
  for i in [1..23]
    Images.insert
      img_src: 'img_' + i + '.jpg'
      img_alt: 'Image number ' + i
      img_label: 'Image ' + i
      img_desc: 'Image number ' + i
      rating: 1
#/ Insert 22 Images

console.log 'Startup Script: ' + 'Number of images are '+ Images.find().count()
