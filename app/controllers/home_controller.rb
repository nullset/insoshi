class HomeController < ApplicationController
  skip_before_filter :require_activation
  
  def index
    @body = "_home"
    @topics = Topic.find_recent
    @members = Person.find_recent
    if logged_in?
      @feed = current_person.feed
      @some_contacts = current_person.some_contacts
      @requested_contacts = current_person.requested_contacts
    else
      @feed = Activity.global_feed
    end
    
    @blog_posts = BlogPost.recent_posts
    @photos = Photo.recent_photos
    
    respond_to do |format|
      format.html
      format.atom
    end  
  end
end
