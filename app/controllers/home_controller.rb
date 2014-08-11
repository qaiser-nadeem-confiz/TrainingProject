class HomeController < ApplicationController
  before_filter :require_login
  skip_before_filter :require_login, only: [:signUp ,:login,:authorise,:handleLogin]
  def index
    if getCurrentUser
     @pendingProfiles=  getCurrentUser.getPendingRequestsProfiles
     @pendingRequests=@pendingProfiles.length
    else @pendingRequests=0
    @pendingProfiles=nil
      end
  end

  def routing_error
    flash[:errorMessage] = "Invalid Url "+request.url
    redirect_to home_index_path
  end

  def signUp
    if user_has_loged_in?
      flash[:errorMessage] = "You are logged in. first logout from this account"
      redirect_to '/'
      else  @account=Account.new
    end

  end
  def authorise
   @account =Account.new(params[:account])
   result= @account.authorizeAccount params[:temp][:password2]
     if result == true
       flash[:message]="Welcome To Social Mesh. You have been successfully signed Up :)"
       redirect_to :action => 'login' , :controller =>'home'
     elsif result ==false
       render 'signUp'
       else
         flash[:errorMessage] = result
       render 'signUp'
     end
  end



  def login
    if user_has_loged_in?
      if request.referer
        redirect_to request.referer
        else redirect_to :action => 'index' , :controller => 'home'
      end

    end
    @loginDetails=Account.new
  end

  def handleLogin
   @loginDetails =Account.new(params[:account])
   @foundedAccount= Account.findAccount(@loginDetails)
    if(@foundedAccount.nil?)
      flash.now[:errorMessage]="Account with this User name does not exists"
      render 'login'
    elsif authenticateUser(@loginDetails,@foundedAccount)
      loginUser @foundedAccount
         if redirectedFromAnotherPage?
           redirectTotheRequestedUrl
         else
         redirect_to user_profile_path(@foundedAccount.userName)
         end
    else
      flash.now[:errorMessage]="Incorrect Password try again"
      render 'login'
    end
  end

  def logout
    session[:loged_in?]=false
    session[:emailId]=nil
    session[:userName]=nil
    redirect_to :action => 'login' , :controller => 'home'
  end


  private
  def loginUser account
    session[:loged_in?]=true
    session[:emailId]=account.emailId
    session[:userName]=account.userName
  end

  private
  def redirectedFromAnotherPage?
    session[:requestedUrl]
  end

  private
  def redirectTotheRequestedUrl
    @url=session[:requestedUrl]
    session[:requestedUrl]=nil
    redirect_to @url
  end


end
