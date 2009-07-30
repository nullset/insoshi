class Admin::PostsController < ApplicationController

  before_filter :login_required, :admin_required

  def index
    @posts = Post.tainted
    @photos = Photo.tainted
    @comments = Comment.tainted
    @topics = Topic.tainted
  end
  
  def accept
    model = params[:model].constantize
    post = model.find(params[:id])
    post.approved_by = current_person.id
    post.tainted = false
    post.rejected = false
    if post.save
      flash[:success] = "#{params[:model].underscore.humanize} approved"
    end
    redirect_to :action => :index
  end
  
  def reject
    model = params[:model].constantize
    post = model.find(params[:id])
    post.tainted = false
    post.rejected = true
    post.approved_by = nil
    person = case
    when post.type == "BlogPost"
      post.blog.person
    else
      post.person
    end
    if post.save
      PersonMailer.deliver_post_rejected(post, person) unless post.respond_to?("commentable_type") { "Comment" }
      flash[:success] = "#{params[:model].underscore.humanize} rejected"
    end
    redirect_to :action => :index
  end
  
  def reject_and_deactivate
    model = params[:model].constantize
    post = model.find(params[:id])
    post.tainted = false
    post.rejected = true
    post.approved_by = nil
    person = case post.type
    when "BlogPost"
      post.blog.person
    else
      post.person
    end
    person.deactivated = true
    if post.save && person.save
      PersonMailer.deliver_post_rejected(post, person)
      flash[:success] = "#{params[:model].underscore.humanize} rejected and the post's author #{person.name} has been deactivated"
    end
    redirect_to :action => :index
  end
  
  def make_featured
    post = Post.find(params[:id])
    tainted = post.tainted? ? true : false
    puts "==========> #{tainted}"
    if params[:position].blank?
      post.featured = false
      post.position = nil
      flash[:success] = "Post has been removed as a featured article"
    else
      old_post = Post.find(:first, :conditions => ["featured is true and position = ?", params[:position]])
      if old_post
        old_post.featured = false
        old_post.position = nil
        old_post.save
      end
      post.featured = true
      post.position = params[:position]
      flash[:success] = "Post has been added as a featured article"
    end
    # if tainted == true
    #   puts "I am true"
    #   post.tainted = true
    # else
    #   puts "I am false"
      post.tainted = false
    # end
    if post.save
      redirect_to :back
    end
  end
  
end
