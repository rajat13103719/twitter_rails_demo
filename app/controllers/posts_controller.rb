
class PostsController < ApplicationController
  #before_action :authenticate_user!
  before_action :set_user
  before_action :load_post,  only: [:show,:delete,:edit]
  before_action :validate_post_owner,  only: [:delete,:edit]

  def get_posts
    page_no = (params[:page] || 0 ).to_i
    post_type = params[:post] == 'draft' ? 'draft' : 'published'

    posts = params[:post] == 'draft' ? @user.posts.draft.order(created_at: :desc).offset(10*page_no).limit(10) : @user.posts.published.order(created_at: :desc).offset(10*page_no).limit(10)
    data = []
    posts.each{|post|
      data_hash = {}
      comments_count = post.comments.size
      likes_count = post.likes.size
      data_hash['id'] = post.id
      data_hash['caption'] = post.data
      data_hash['comments'] = comments_count
      data_hash['likes'] = likes_count
      data << data_hash

    }
    render :json=>{posts:data}
  end

  def show
    page_no = (params[:page] || 0 ).to_i
    
    comments = @post.comments.order(created_at: :desc).offset(10*page_no).limit(10)
    likes = @post.likes.order(created_at: :desc).map{|x| x.user.email}
    data = []
    comments.each{|comment|
      comment_likes = comment.likes.size
      comment_hash = {}
      comment_hash['id'] = comment.id
      comment_hash['posted_by'] = comment.user.email
      comment_hash['likes'] = comment_likes
      data << comment_hash
    }
    data_hash = {}
    data_hash['id'] = @post.id
    data_hash['caption'] = @post.data
    data_hash['comments'] = data
    data_hash['likes'] = likes
    render :json=>{post_details:data_hash}
  end

  def new
    caption = params[:caption] || ''
    @post = Post.new(:user=>@user,:data=>caption,:status=>'draft')
    @post.save!
    render :json=> {success:true,post_id:@post.id}
  end

  def edit
    caption = params[:caption]
    @post.update(data:caption,status:draft)
    render :json=> {success:true,post_id:@post.id}
  end 

  def publish_post
    @post.update(status:'published')
    render :json=> {success:true,post_id:@post.id}
  end

  def delete
    post.update(status:'deleted')
    render :json=> {success:true,post_id:@post.id}
  end
  
  def set_user
    @user = User.find_by_email(params[:email])
    render :file => "public/401.html", :status => :unauthorized and return unless @user
  end

  def load_post
    post_id = params[:post_id]
    @post = Post.find_by_id(post_id.to_i) unless post_id.blank?
    if @post.blank?
      render :file => "public/404.html", :status => :not_found and return
    end
  end

  def validate_post_owner
    if @post.user != @user
      render :file => "public/401.html", :status => :unauthorized and return
    end
  end
  
end
