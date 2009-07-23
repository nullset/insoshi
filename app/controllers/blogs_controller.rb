class BlogsController < ApplicationController

  # before_filter :login_required

  def show
    @body = "blog"
    @blog = Blog.find(params[:id])
    @person = @blog.person
    @posts = @blog.posts.all.paginate(:page => params[:page])
    
    respond_to do |format|
      format.html
    end
  end
end
