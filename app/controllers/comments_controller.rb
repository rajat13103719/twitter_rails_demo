
class CommentsController < ApplicationController
  #before_action :authenticate_user!
  before_action :set_user
  before_action :load_comment,  only: [:show,:delete,:edit]
  before_action :validate_comment_owner,  only: [:show,:delete,:edit]

  

  def show
    
    likes = @comment.likes.order(created_at: :desc).map{|x| x.user.email}
    
    data_hash = {}
    data_hash['id'] = @comment.id
    data_hash['caption'] = @comment.data
    data_hash['likes'] = likes
    render :json=>{comment_details:data_hash}
  end

  def new
    caption = params[:caption] || ''
    post_id = params[:post_id]
    @post = Post.find_by_id(post_id) unless post_id.blank?
    if @post.blank?
      render_404 and return
    end
    @comment = Comment.new(:user=>@user,:data=>caption,:post=>@post)
    @comment.save!
    render :json=> {success:true,comment_id:@comment.id}
  end

  def delete
    @comment.destroy!
    render :json=> {success:true}
  end

  def edit
    caption = params[:caption]
    @comment.update(data:caption)
    render :json=> {success:true,comment_id:@comment.id}
  end 

  
  
  def set_user
    @user = User.find_by_email(params[:email])
    render_401 and return unless @user
  end

  def load_comment
    comment_id = params[:comment_id]
    @comment = Comment.find_by_id(comment_id.to_i) unless comment_id.blank?
    render_404 and return unless @comment
  end

  def validate_comment_owner
    if @comment.user != @user
      render_404 and return
    end  
  end
  
end
