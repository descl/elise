module Elise
  class AccountController < ApplicationController
    # GET /login
    def login
      account = Account.authenticate(params[:login], params[:password])
      if account
        session[:account_id] = account.id
        session[:roleId] = account.get_roles[0].id
        session[:roleLabel] = account.get_roles[0].label
        redirect_to :back, :flash => { :notice => "Logged in!" }
      else
        redirect_to elise_url, :flash => { :error => "Invalid login or password!"}
      end
    end
    
    # GET /logout
    def logout
      session[:account_id] = nil
      session[:roleId] = nil
      session[:roleLabel] = nil
      redirect_to :back, :flash => {  :notice => "Logged out!" }
    end
    
    # GET /role
    def role
      session[:roleId] = params[:roleId]
      session[:roleLabel] = params[:roleLabel]
      redirect_to :back, :flash => {  :notice => "Role changed!" }
    end
    def index
    end

  end
end