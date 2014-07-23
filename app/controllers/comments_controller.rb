class CommentsController < ApplicationController
  include ActionView::Helpers::SanitizeHelper
  def new

  end
  def create
 @CommentedBy=getProfile
 @CommentedOn =UserProfile.find(params[:user_profile_id])
 @comment= @CommentedOn.comments.new(params[:comment])
 @comment=initializeComment @comment, @CommentedBy
 @comment.save
    redirect_to user_profile_path(@CommentedOn.userName)
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
    @deletingPerson =getProfile
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
