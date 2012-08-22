module Elise
  ## Define ControllerMethods
    module Controller
      extend ActiveSupport::Concern
      included do
        helper_method :current_user
        before_filter :set_special_layout_elise
      end
    
      def set_special_layout_elise
        module_name = self.class.name.split("::").first
        if module_name == 'Elise'
          self.class.layout "elise/layouts/application"
        end
      end
      
      module InstanceMethods
        def current_user
            return Account.current_user(session)
        end
      end
    end

end
::ActionController::Base.send :include, Elise::Controller


