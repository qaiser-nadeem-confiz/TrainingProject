class CommentsController < ApplicationController
  include ActionView::Helpers::SanitizeHelper
  before_filter :'require_login','profile_added?'
  def new

  end
  def create

    @loggedUser=getCurrentUser
    @profile=UserProfile.find(params[:user_profile_id])
 @CommentedBy=getCurrentUser
 @CommentedOn =UserProfile.find(params[:user_profile_id])
 @comment= @CommentedOn.comments.new(params[:comment])
 @comment=initializeComment @comment, @CommentedBy
 respond_to do |format|
   if @comment.save
     format.html { redirect_to user_profile_path(@CommentedOn.userName)}
     format.js   {render   :layout => false}
     format.json { render json: @comment, status: :created, location: @comment }
   else
     format.html { render action: "new" }
     format.js   {render :layout => false}
     format.json { render json: @comment.errors, status: :unprocessable_entity }
   end
 end
  end


  def destroy
    @userProfile = UserProfile.find(params[:user_profile_id])
    @comment = @userProfile.comments.find(params[:id]);
    if deleteAuthorised? @userProfile,@comment
    @comment.destroy
    else
      flash[:errorMessage]="You are not authorised to delete this comment"
      end
    redirect_to user_profile_path(@userProfile.userName)
  end

  private
  def deleteAuthorised? (userProfileForCommentDelete , comment)
    @deletingPerson =getCurrentUser
    if(@deletingPerson.id==userProfileForCommentDelete.id)
      return true
    elsif @deletingPerson.id==comment.commentedBy
      return true
    else return false
    end
  end

private
  def initializeComment(comment,commenter)
    comment.commentedBy=commenter.id
    comment.commentTimeDate=DateTime.now
    comment.commentType="private"
    return comment
end



end
