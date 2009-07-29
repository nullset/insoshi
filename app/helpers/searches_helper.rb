module SearchesHelper
  
  # Return the model to be searched based on params.
  def search_model
    return "BlogPost"    if params[:controller] =~ /home|blogs|posts/
    return "ForumPost" if params[:controller] =~ /forums/
    return "BlogPost"    if params[:controller] =~ /blogs/
    return "Person"    if params[:controller] =~ /galleries|connections/
    params[:model] || params[:controller].classify
  end
  
  def search_type
    if params[:controller] =~ /home|blogs|posts/ or params[:model] == "BlogPost"
      "Blogs"
    elsif params[:controller] == "forums" or params[:model] == "ForumPost"
      "Forums" 
    elsif params[:controller] == "messages" or params[:model] == "Message"
      "Messages"
    else
      "People"
    end
  end
  
  # Return the partial (including path) for the given object.
  # partial can also accept an array of objects (of the same type).
  def partial(object)
    object = object.first if object.is_a?(Array)
    klass = object.class.to_s
    case klass
    when "ForumPost"
      dir  = "topics" 
      part = "search_result"
    when "AllPerson"
      dir  = 'people'
      part = 'person'
    when "BlogPost"
      dir = 'blogs'
      part = 'search_result'
    else
      dir  = klass.tableize  # E.g., 'Person' becomes 'people'
      part = dir.singularize # E.g., 'people' becomes 'person'
    end
    admin_search? ? "admin/#{dir}/#{part}" : "#{dir}/#{part}"
  end

  private
  
    def admin_search?
      params[:model] =~ /Admin/
    end
end
