class UserProfilesController < ApplicationController
before_filter :'require_login'
before_filter 'profile_added?' , except: [:new , :edit,:create]
  def new
    @user_profile=UserProfile.new
    if profileAlreadyExists?
       @user_profile=   getCurrentUser
      redirect_to action: 'edit'
 end
  end
  def index
    if user_is_not_searching?
      @profiles=UserProfile.all
    else

      #@profiles=UserProfile.search :with => {:emailId => params[:q]}
      @profiles=UserProfile.search params[:q]
      if @profiles.length>0
        set_notice @profiles.length.to_s + " person found"
        else set_error_message "No Person found"
      end
    end
    @profile=getCurrentUser

    @facets=UserProfile.facets params[:q],:conditions => {:id => 2}


  end


def sendRequest
  @friendRequest=  FriendRequest.new
  @sender=getCurrentUser
  @requestTo =getProfileByUserName params[:id]

  if @friendRequest.alreadyFriend? @sender , @requestTo
    set_error_message "Request Already sent"
  elsif @friendRequest.requestAlreadySent? @sender , @requestTo
    set_error_message "You Are Already Friends"
  end

  if request_to_found_and_request_saved?
    set_notice "Request Sent!"
  else set_error_message @requestTo + " Was not found"
  end
  redirect_to request.referer
end





def makeFriends
  @friendFrom =getProfileByUserName [params[:id]]
  @logedUser= getCurrentUser
 if @logedUser.acceptFriendRequest @friendFrom
   set_notice "Congratulations You and #{@friendFrom.firstName} are friends Now"
   else set_error_message"Sorry Could not add you as friend"
   end
  redirect_to request.referer
end

def rejectFriendRequest
  @friendFrom =getProfileByUserName [params[:id]]
  @logedUser= getCurrentUser
  if @logedUser.rejectFriendRequest @friendFrom
    set_notice "Friend Request Rejected"
    else set_notice "Request Could not be reject"
    end
  redirect_to request.referer
end


def edit
  if profileAlreadyExists?
    @user_profile=   getCurrentUser

    else redirect_to action: new
   end
end

def update
@user_profile =getCurrentUser
if(@user_profile.update_attributes(params[:user_profile]))
    save_new_display_picture @user_profile, params[:file]
    set_notice "Profile Upated Successfully"
    redirect_to action: 'index' ,controller: 'user_profiles'
else render 'edit'
end

end
  def create
    @user_profile=UserProfile.new(params[:user_profile])
    @user_profile.initializeAttributess getEmail,getUserName , params[:file]
    if(@user_profile.valid? and params[:file]  and @user_profile.save)
      @user_profile.savePhoto params[:file]
      set_notice "Profile Updated Successfully"
      redirect_to action: 'index'
    elsif(params[:file].nil?)
      set_error_message "Please choose a DP for your profile"
      render 'new'
    else
      render 'new'
      end

   end


def show
  @loggedUser=getCurrentUser
  if UserProfile.find_by_userName(params[:id])
    @profile=UserProfile.find_by_userName(params[:id])
  else  @profile=getCurrentUser
    set_error_message"Profile with id " +params[:id] + " Could not be found"
  end


end


private
def request_to_found_and_request_saved? (friendRequest , requestTo)
  if getProfileByUserName requestTo
    friendRequest.requestFrom=sender.userName
    friendRequest.requestTo=requestTo.userName
    friendRequest.save
  else false
    end
end

private
  def user_is_not_searching?
    params[:q].blank?
  end



private
def save_new_display_picture (user, file)
  if file
    user.update_attribute 'pictureUrl' ,user.getPictureUrl(file)
    user.savePhoto file
  end
end

end

