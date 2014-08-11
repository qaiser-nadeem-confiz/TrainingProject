require 'test_helper'

class UserFlowsTest < ActionDispatch::IntegrationTest
  fixtures :all
test "Login and see user profiles list"  do
@account=accounts(:qaisar)
post '/login' , :account => {:userName => @account.emailId , :password => @account.password}
get '/login'
assert_response 302
get 'logout'
get 'login'
assert_response :success

post_via_redirect '/login' , :account => {:userName => @account.emailId , :password => @account.password}
if(UserProfile.find_by_userName @account.userName).nil?
  assert_equal '/user_profiles/new' , path
  get '/user_profiles'
  assert_redirected_to '/user_profiles/new'
else assert_equal user_profile_path(@account.userName) , path
  get '/user_profiles'
  assert_response :success
end


end

end
