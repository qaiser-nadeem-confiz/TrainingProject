class HomeController < ApplicationController
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
       redirect_to :action => 'index' , :controller =>'home'
     else
       @account.valid?
       render 'signUp'
     end
  end
end
