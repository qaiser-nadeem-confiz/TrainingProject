class FriendRequestController < ApplicationController
before_filter :require_login
  def sendRequest
      @sender=getProfile
      @requestTo = params[:id]
      if getProfileByUserName @requestTo
       @friendRequest=  FriendRequest.new
        @friendRequest.requestFrom=@sender.userName
        @friendRequest.requestTo=@requestTo
        @friendRequest.save
      else flash[:errorMessage]=@requestTo + " Was not found"
      end
    redirect_to user_profile_path
  end



private
def alreadyFriend? from , to
  @fr=FriendList.new

  @friends=UserProfile.where()
end

  private
  def requestAlreadySent? from ,to
  @friendRequest =FriendRequest.new
    @requests= FriendRequest.where("requestTo = '"+to+"' and requestFrom = '"+from+"' or
    requestTo = '"+from+"' and requestFrom = '"+to+"'")
    if(@requests.nil?)
      return false
      else return true
    end

  end
end
