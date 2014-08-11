ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.(yml|csv) for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  fixtures :all

def logInUser acc
  @account=acc
  post :handleLogin , :account => {:userName => @account.emailId , :password => @account.password}
end

  def user_Logged_in?
   session[:loged_in?]
  end

  def user_logged_out?
    session[:loged_in?]==false and
    session[:emailId].nil? and
    session[:userName].nil?
  end

  def logOutUser
    session[:loged_in?]=false
    session[:emailId]=nil
    session[:userName]=nil
  end


  def valid_attribute?(model , attribute)
    model.valid?
    model.errors[attribute].blank?
  end

  def  attribute_presence_enforced?(model , attribute)
    model[attribute].present?
        (!model[attribute].present? and !valid_attribute? model , attribute)
  end



  # Add more helper methods to be used by all tests here...
end
