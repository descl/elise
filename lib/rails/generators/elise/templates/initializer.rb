module Elise
  class Engine < Rails::Engine

    config.mount_at = '/elise'
    config.widget_factory_name = 'Factory Name'
        
  end
end
