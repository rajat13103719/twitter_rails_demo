Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  match :get_user_posts, to: 'posts#get_posts', as: :get_user_posts, via: :get
  match :get_post_details, to: 'posts#show', as: :get_post_details, via: :get
  match :new_post, to: 'posts#new', as: :new_post, via: :post
  match :edit_post, to: 'posts#edit', as: :edit_post, via: :post
  match :publish_post, to: 'posts#publish_post', as: :publish_post, via: :publish_post
  match :delete_post, to: 'posts#delete', as: :delete_post, via: :post

  match :get_comment_details, to: 'comments#show', as: :get_comment_details, via: :get
  match :new_comment, to: 'comments#new', as: :new_comment, via: :post
  match :edit_comment, to: 'comments#edit', as: :edit_comment, via: :post
  match :delete_comment, to: 'comments#delete', as: :delete_comment, via: :post

  match :new_like, to: 'likes#new', as: :new_like, via: :post
  match :delete_like, to: 'likes#delete', as: :delete_like, via: :post
end
