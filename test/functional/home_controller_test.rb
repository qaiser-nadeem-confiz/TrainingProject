require 'test_helper'

class HomeControllerTest < ActionController::TestCase
setup do
  @account=accounts(:qaisar)
end

test "If not logged in then User should be redirected to Login page" do
  get :index
  logOutUser
  assert_redirected_to '/login'
end


test "Login  should be accessible" do
  get :login
  assert_response :success
end

test "User should be logged in after loging in" do

  post :handleLogin , :account => {:userName => @account.emailId , :password => @account.password}
  assert_equal  true ,session[:loged_in?]
  assert_equal @account.emailId , session[:emailId]
  assert_equal @account.userName , session[:userName]
end

test "If logged in then User can access index" do

  logInUser @account
  get :index
  assert_response :success
end

  test "User should be logged out and session shoud be expired after loging out" do

    logInUser @account
    get :logout
    assert_equal true, user_logged_out?
  end

  test "show signup page when accessed and not logged in" do

    logOutUser
    get :signUp
    assert_response :success
  end

  test "user should be redirected to Home Page if hes already logged in and try to sign up" do
    logInUser @account
    get :signUp
    assert_redirected_to '/'
  end


  test "Account should be created after authorizing the sign up data"do
    assert_difference('Account.count') do
      post :authorise ,{ :account => {:userName=>"temp5689", password: "password",
      :emailId=>"201yy0cs@gmail.com"} , :temp => {:password2 => "password"}
      }
    end
assert_redirected_to '/login'
  end


end
