module Elise
  class Account < User
    
    attr_accessor :cur_roleId, :cur_roleLabel
    @cur_roleId = nil
    @cur_roleLabel = nil

    def self.authenticate(login, password)
      user = Account.all.find_all{|i|  i.login == login}[0]
      if user && user.cryptedPassword == password
        user
      else
        nil
      end
    end
    
    def is_logged
      return self.entity_def_id != nil
    end
    
    def self.current_user(session)
      if session[:account_id] != nil
        account = Account.find(session[:account_id])
        account.cur_roleId = session[:roleId]
        account.cur_roleLabel = session[:roleLabel]
        return account
      else
        return Account.new
      end
    end
    
    def get_roles
      rolesList = Array.new
      
      #check if there is one or more roles
      if self.roleId.is_a?(String)
        rolesList.push(Feature.find_by_id(id))
        return rolesList
      end
      
      self.roleId.each do |id|
        rolesList.push(Feature.find_by_id(id))
      end
      rolesList
    end

    def can_see_feature(feature)
      #check if the feature exist
      return false if ! (defined? feature)
      
      begin
        #check if there is one or more roles
        return self.cur_roleId == feature.roleId if feature.roleId.is_a?(String)
      rescue
        return false
      end

      #for array of roles
      return feature.roleId.include?(self.cur_roleId)
    end
    
    def can_see_feature_name(featureName)
      feature = Feature.find_by_label(featureName)
      
      if feature == nil
        #the feature doesn't exist, we can create an empty feature
        feature = Feature.new(:label => featureName, :entity_def_id => 'Feature')
        feature.save
      end
      
      return can_see_feature(feature)
    end
    def can_see(featureName)
      return can_see_feature_name(featureName)
    end
  end
  
end