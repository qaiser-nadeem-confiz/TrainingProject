class UserProfilesController < ApplicationController
before_filter :'require_login'
  def new
    @user_profile=UserProfile.new
    if profileAlreadyExists?
       @user_profile=   getProfile
      redirect_to action: 'edit'
 end
  end
  def index
    @profiles=UserProfile.all
    @profile=getProfile
  end
def sendRequest
  @friendRequest=  FriendRequest.new
  @sender=getProfile
  @requestTo =getProfileByUserName params[:id]

  if @friendRequest.alreadyFriend? @sender , @requestTo
    flash[:errorMessage]="Request Already sent"
  elsif @friendRequest.requestAlreadySent? @sender , @requestTo
    flash[:errorMessage]="You Are Already Friends"
  end

  if getProfileByUserName @requestTo
    @friendRequest.requestFrom=@sender.userName
    @friendRequest.requestTo=@requestTo.userName
    @friendRequest.save
  else flash[:errorMessage]=@requestTo + " Was not found"
  end
  redirect_to user_profile_path
end

def edit
  if profileAlreadyExists?
    @user_profile=   getProfile

    else redirect_to action: new
   end
end

def update
@user_profile =getProfile
if(@user_profile.update_attributes(params[:user_profile]))
  if(params[:file])
    @user_profile.update_attribute 'pictureUrl' ,@user_profile.getPictureUrl(params[:file])
  end
  flash[:message] ="Profile Upated Successfully"
  redirect_to action: 'index' ,controller: 'user_profiles'

else render 'edit'
end

end
  def create
    @user_profile=UserProfile.new(params[:user_profile])
    @user_profile.initializeAttributess getEmail,getUserName , params[:file]
    if(@user_profile.valid? and params[:file]  and @user_profile.save)
      @user_profile.savePhoto params[:file]
      flash[:message]="Profile Updated Successfully"
      redirect_to action: 'index'
    elsif(params[:file].nil?)
      flash[:errorMessage]="Please choose a DP for your profile"
      render 'new'
    else
      render 'new'
      end

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


end




end

