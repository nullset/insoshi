class HomeController < ApplicationController
  skip_before_filter :require_activation
  
  def index
    @body = "_home"
    @topics = Topic.find_recent
    @members = Person.find_recent
    unless logged_in?
      @feed = Activity.global_feed
    end

    @intro = Person.find(:first, :conditions => ["admin = ?", true]).blog.posts.find(:first, :order => "created_at desc")
    # TODO : Make featured posts
    @featured_posts = Post.find(:all, :conditions => ["featured = ?", true], :order => "position")
    @blog_posts = BlogPost.recent_posts
    @photos = Photo.recent_photos
    
    respond_to do |format|
      format.html
      format.atom
    end  
  end
end
