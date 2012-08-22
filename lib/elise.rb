module Elise
  require 'application_controller'
  require File.expand_path('../engine', __FILE__)
  require File.expand_path('../application_controller', __FILE__)
  
  module Elise
    
  end
  def extraRoutes(map)
    
    mount_at =  '/elise'
    
    
    map.with_options(:path_prefix => mount_at, :name_prefix => "elise_") do |t|
      t.login     "login",    :controller => "elise/account", :action => "login"
      t.logout    "logout",   :controller => "elise/account", :action => "logout"
      t.role      "role",     :controller => "elise/account", :action => "role"
      t.resources :features,  :controller => "elise/features"

    end 
    map.elise 'elise', 
        :action => 'index', 
        :controller => 'elise/account'
  end
  module_function :extraRoutes
end
