I've used Json based apis to demostrate request flow for management of posts,comments and likes for a Twitter like feed experience in this project. Since all apis are Json based there is no Ui/Ux component in the app. I've not implemented authorizaion of users. It can be done via a token based approach that is stateless and does not depend on any session based architecture that's maintained on server.
Api endpoints in app:

1. get_user_posts :
	Params: 
		email : email-id of user
		page  : page no. for pagination
	Response:
		Json of at most 10 posts for given user. Json contains details of post like id,caption,number of comments and likes


2. get_post_details
	Params:
		email   : email-id of user
		post_id : id of post
		page    : page no. for pagination
  Response:
  		Json containing details of post as well as comments associated with the post


 3.  new_post
 	Params:
 		email  	: email-id of user
 		caption  : caption of post		
  	Response:
  		Status of post creation(boolean flag) along with id of new post(if successs)
4. edit_post
  	Params:
  		email   : email-id of user
  		caption : updated caption of post
  		post_id : id of post
	Response:
  		Status of post creation(boolean flag) along with id of new post(if successs)
  
5. publish_post
	Params:
  		email   : email-id of user
  		post_id : id of post
	Response:
  		Status of update of post status to 'published'
  		
 6. delete_post
 	Params:
 		email   :	email-id of user
 		post_id :   id of post
 	Response:
  		Status of post deletion

 7. get_comment_details
 	Params:
 		email : email id of user
 		comment_id : id of comment
 	Response:
 		Json containing details of comment along with likes on comment	 			
  
  8. new_comment
  	Params :
  		email : email-id of user
  		post_id : id of post
  		caption : comment caption
  	Response:
  		Status of comment creation


  9. edit_comment		
  	Params :
  		email : email-id of user
  		comment_id : id of comment
  		caption : updated caption
  	Response:
  		Status of comment edit	
 
 10. delete_comment
 	Params :
  		email : email-id of user
  		comment_id : id of comment
  		
  	Response:
  		Status of comment deletion	 
 11. new_like 
 	Params:
 		email : email-id of user
 		likeable : 'post' or 'comment' depending upon what's being liked at client side
 		likeable_id : id of post or comment
 	Response:
 		Status of like
12. delete_like 	
	Params:
 		email : email-id of user
 		like_id : id of like
 		
 	Response:
 		Status of like deletion


Note: Once authorization is implemented, email can be replaced with api_key as input parameter for all requests.  		