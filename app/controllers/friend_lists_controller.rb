class FriendListsController < ApplicationController
  before_filter :'require_login'
def index
@profiles=FriendList.getFriendsProfiles getProfile
@profile=getProfile
flash[:message] ="You have #{@profiles.length} friends"
  render 'user_profiles/index'
end

def show
  @loggedUser=getProfile
  if UserProfile.find_by_userName(params[:id])
    @profile=UserProfile.find_by_userName(params[:id])
  elsif(getProfile.nil?)
    redirect_to action: 'new'
  else  @profile=getProfile
  flash[:errorMessage] = "Profile with id " +params[:id] + " Could not be found"
  end
  render 'user_profiles/show'
end


def destroy
  @friend=  getProfileByUserName params[:id]
 if FriendList.unfriend getProfile , @friend
   flash[:message] = "You and #{@friend.firstName } are no more friends"
   else flash[:errorMessage] =  "Could not un friend you"
 end
redirect_to controller: 'user_profiles' , action: 'index'
end

end
