class FriendRequestController < ApplicationController
before_filter :require_login,'profile_added?'

def index

end

  def sendRequest
      @sender=getCurrentUser
      @requestTo =getProfileByUserName params[:id]
      handleRequest @sender , @requestTo
     redirect_to controller: 'user_profiles' , action: 'index'
  end


   def showPending
     @profiles=getCurrentUser.getPendingRequestsProfiles
     @profile=getCurrentUser
     render 'user_profiles/index'
   end

  private

 def  handleRequest sender , requestTo
   @friendRequest=  FriendRequest.new
   if(sender.id==requestTo.id)
     flash[:errorMessage]="You Cannot Add yourself as Friend"
   elsif @friendRequest.alreadyFriend? sender , requestTo
     flash[:errorMessage]="You Are Already Friends"
   elsif FriendRequest.requestAlreadySent? sender , requestTo
     flash[:errorMessage]="Request Already sent"
   elsif requestTo.userName
         @friendRequest.saveRequest sender , requestTo
     flash[:message]="Request sent successfully"
   else flash[:errorMessage]=requestTo.userName + " Was not found"
   end
 end
end
