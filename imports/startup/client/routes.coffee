#ApplicationLayout
require '/imports/ui/layouts/ApplicationLayout.coffee'
require '/imports/ui/layouts/ApplicationLayoutNavless.coffee'

#Components
require '/imports/ui/components/welcome/index.coffee'
require '/imports/ui/components/images/index.coffee'

Router.configure
  layoutTemplate: 'ApplicationLayout'

Router.route '/', ->
  @layout 'ApplicationLayoutNavless'
  @render 'welcome', {
    to: 'main'
  }

Router.route '/images', ->
  @render 'images'