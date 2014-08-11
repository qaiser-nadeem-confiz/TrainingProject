require 'test_helper'

class UserProfileTest < ActiveSupport::TestCase
 test "User's Email id and UserName must be present" do
   @profile = user_profiles(:first)
   assert_not_nil @profile.emailId
   assert_not_nil @profile.userName
 end
  test "User emmail and userName must be valid like Account" do
    @profile=user_profiles(:first)
    @account=Account.new(emailId: @profile.emailId,userName: @profile.userName)
    assert valid_attribute?(@account,'emailId') , "Invalid email id"
    assert valid_attribute?(@account,'userName') , "Invalid userName"
  end






end
