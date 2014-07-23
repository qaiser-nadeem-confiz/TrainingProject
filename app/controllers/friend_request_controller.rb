class FriendRequestController < ApplicationController
before_filter :require_login

def index

end

  def sendRequest
    @friendRequest=  FriendRequest.new
      @sender=getProfile
      @requestTo =getProfileByUserName params[:id]

      if @friendRequest.alreadyFriend? @sender , @requestTo
        flash[:errorMessage]="You Are Already Friends"
      elsif @friendRequest.requestAlreadySent? @sender , @requestTo
        flash[:message]="Request Sent Successfully"
      end

      if getProfileByUserName @requestTo.userName
        @friendRequest.requestFrom=@sender.userName
        @friendRequest.requestTo=@requestTo.userName
        @friendRequest.save
      else flash[:errorMessage]=@requestTo.userName + " Was not found"
      end
    redirect_to controller: 'user_profiles' , action: 'index'
  end
end
