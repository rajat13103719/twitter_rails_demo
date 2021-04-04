
class LikesController < ApplicationController
  #before_action :authenticate_user!
  before_action :set_user
  before_action :load_like,  only: [:delete]
  before_action :validate_like_owner,  only: [:delete]

  

  

  def new
    likeable = params[:likeable] == 'post' ? 'post' : 'comment'
    likeable_id = params[:likeable_id]
    @likeable = likeable == 'post' ? Post.find_by_id(likeable_id) : Comment.find_by_id(likeable_id)
    if @likeable.blank?
      render :file => "public/401.html", :status => :unauthorized and return
    end
    @like = Like.where(:likeable=>@likeable,:user=>@user).first
    success = false
    if @like.blank?
      @like = Like.new(:likeable=>@likeable,:user=>@user)
      @like.save!
      success = true
    end
    
    render :json=> {success:success,like_id:@like.id}
  end

  def delete
    @like.destroy!
    render :json=> {success:true}
  end

   

  
  
  def set_user
    @user = User.find_by_email(params[:email])
    render :file => "public/401.html", :status => :unauthorized and return unless @user
  end

  def load_like
    like_id = params[:like_id]
    @like = Like.find_by_id(like_id.to_i) unless like_id.blank?
    render :file => "public/404.html", :status => :not_found and return unless @like
  end

  def validate_comment_owner
    if @like.user != @user
      render :file => "public/401.html", :status => :unauthorized and return
    end  
  end
  
end
