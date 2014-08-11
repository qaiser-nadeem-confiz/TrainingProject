require 'test_helper'

class CommentTest < ActiveSupport::TestCase
test "Comment should not be blank" do
  @comment=Comment.new

  assert !@comment.save , "empty comment cannot be saved"
end

test "Commentor and Commented on must be present before saving" do
  @comment=Comment.new
  assert attribute_presence_enforced?(@comment,'user_profile_id') , "Commented on presence not enforced"
  assert attribute_presence_enforced?(@comment,"commentedBy") , "Commenter presence not enforced"
end

end
