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
    @user_profile.update_attribute 'pictureUrl' ,getPictureUrl(params[:file])
  end
  flash[:message] ="Profile Upated Successfully"
  redirect_to action: 'index' ,controller: 'user_profiles'

else render 'edit'
end

end
  def create
    @user_profile=UserProfile.new(params[:user_profile])
    @user_profile=initializeProfile @user_profile , params[:file]
    if(@user_profile.valid? and params[:file]  and @user_profile.save)
      savePhoto params[:file]
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


private
def initializeProfile (userProfile,file)
  userProfile=userProfile
  userProfile.accountType='normal'
  userProfile.dateOfJoining=Date.today
  userProfile.emailId=getEmail
  userProfile.isActive=true
  userProfile.userName=getUserName
  if(file)
    userProfile.pictureUrl=getPictureUrl file
  end
  return userProfile
end


private
def getPictureUrl file
  handleDirectoryMaking+file.original_filename
end

private

def savePhoto(file)
  uploaded_file = file
  folder=handleDirectoryMaking
  File.open(folder+uploaded_file.original_filename, 'wb') do |file|
    file.write(uploaded_file.read)
  end
end

private

def handleDirectoryMaking
  dir = File.dirname("#{Rails.root}/public/Users/Photoes/temp")
  FileUtils.mkdir_p(dir+"/"+getEmail)
  return dir+'/'+getEmail+"/"
  end
end

