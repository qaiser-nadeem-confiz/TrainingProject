require 'test_helper'

class AccountTest < ActiveSupport::TestCase
   test "Account should be valid before Save" do
     @account=accounts(:qaisar)
     assert @account.valid?
   end


  test "invalid account gives Error message" do
    @account=accounts(:qaisar)
    @account.emailId=nil
    @account.valid?
    assert_match /can't be blank/, @account.errors[:emailId].join
  end



end
