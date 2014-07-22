class HomeController < ApplicationController
  before_filter :require_login
  skip_before_filter :require_login, only: [:signUp ,:login,:authorise,:handleLogin]
  def index

  end

  def signUp
    @account=Account.new
  end
  def authorise
   @account =Account.new(params[:account])
   @valid =true
   @account2=Account.where("emailId='"+@account.emailId+"' or userName='"+@account.userName+"'")
   if(@account2.length>0)
     flash.now[:errorMessage] = "User Name/Email Id Already Exists"
     @valid=false
   elsif(@account.password.to_s!=params[:temp][:password2])
     flash.now[:errorMessage] = "Password does not match"
     @valid=false
   end
     if @valid  and @account.save
       flash[:message]="Welcome To Social Mesh. You have been successfully signed Up :)"
       redirect_to :action => 'login' , :controller =>'home'
     else

       @account.valid?
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
   @foundedAccount= findAccount(@loginDetails)
    if(@foundedAccount.nil?)
      flash.now[:errorMessage]="Account with this User name does not exists"
      render 'login'
    elsif authenticateUser(@loginDetails,@foundedAccount)
      session[:loged_in?]=true
      session[:emailId]=@foundedAccount.emailId
      session[:userName]=@foundedAccount.userName
      if session[:requestedUrl]
        @url=session[:requestedUrl]
        session[:requestedUrl]=nil
        redirect_to @url
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




end
