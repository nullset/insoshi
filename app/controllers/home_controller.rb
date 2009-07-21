class HomeController < ApplicationController
  skip_before_filter :require_activation
  
  def index
    @body = "_home"
    if logged_in?
      @requested_contacts = current_person.requested_contacts
    else
      @feed = Activity.global_feed
    end

    @intro = Person.find(:first, :conditions => ["admin = ?", true]).blog.posts.find(:first, :order => "created_at desc")
    @featured_posts = Post.find(:all, :conditions => ["featured = ?", true], :order => "position")
    
    respond_to do |format|
      format.html
      format.atom
    end  
  end
end
