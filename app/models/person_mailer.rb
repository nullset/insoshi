class PersonMailer < ActionMailer::Base
  extend PreferencesHelper
  
  def domain
    @domain ||= PersonMailer.global_prefs.domain
  end
  
  def server
    @server_name ||= PersonMailer.global_prefs.server_name
  end
  
  def password_reminder(person)
    from         "Password reminder <no-reply@#{domain}>"
    recipients   person.email
    subject      formatted_subject("Password reminder")
    body         "person" => person
  end
  
  def message_notification(message)
    from         "Message notification <no-reply@#{domain}>"
    recipients   message.recipient.email
    subject      formatted_subject("New message")
    body         "server" => server, "message" => message,
                 "preferences_note" => preferences_note(message.recipient),
                 "url" => person_message_path(message.recipient, message)
  end
  
  def connection_request(connection)
    from         "Contact request <no-reply@#{domain}>"
    recipients   connection.person.email
    subject      formatted_subject("Contact request from #{connection.contact.name}")
    body         "server" => server,
                 "connection" => connection,
                 "url" => edit_connection_path(connection),
                 "preferences_note" => preferences_note(connection.person)
  end
  
  def blog_comment_notification(comment)
    from         "Comment notification <no-reply@#{domain}>"
    recipients   comment.commented_person.email
    subject      formatted_subject("New blog comment")
    body         "server" => server, "comment" => comment,
                 "url" => 
                 person_blog_post_path(comment.commentable.blog.person, comment.commentable.blog, comment.commentable),
                 "preferences_note" => 
                    preferences_note(comment.commented_person)
  end
  
  def wall_comment_notification(comment)
    from         "Comment notification <no-reply@#{domain}>"
    recipients   comment.commented_person.email
    subject      formatted_subject("New wall comment")
    body         "server" => server, "comment" => comment,
                 "url" => person_path(comment.commentable, :anchor => "wall"),
                 "preferences_note" => 
                    preferences_note(comment.commented_person)
  end
  
  def email_verification(ev)
    from         "Email verification <no-reply@#{domain}>"
    recipients   ev.person.email
    subject      formatted_subject("Email verification")
    body         "server_name" => server,
                 "code" => ev.code
  end
  
  def post_rejected(object, person)
    from         "Admin <no-reply@#{domain}>"
    recipients  "#{person.name} <#{person.email}>"
    case object.class.to_s
    when "BlogPost"
      url = person_blog_post_path(object.blog.person, object.blog, object)
    when "ForumPost"
      url = forum_topic_path(object.topic.forum, object.topic, :anchor => "post_#{object.id}")
    when "Photo"
      url = person_gallery_photo_path(object.gallery.person, object.gallery, object)
    when "Topic"
      url = forum_topic_path(object.forum, object)
    when "Comment"
      url = nil
    end
    obj = object.class.to_s.underscore.humanize.downcase

    subject      formatted_subject("Your #{obj} has been rejected")
    body         "server" => server,
                 "url" => url,
                 "obj" => obj
  end
  
  private
  
    # Prepend the application name to subjects if present in preferences.
    def formatted_subject(text)
      name = PersonMailer.global_prefs.app_name
      label = name.blank? ? "" : "[#{name}] "
      "#{label}#{text}"
    end
  
    def preferences_note(person)
      %(To change your email notification preferences, visit http://#{server}/people/#{person.to_param}/edit#email_prefs)
    end
end
