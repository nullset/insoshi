class AdminMailer < ActionMailer::Base

  extend PreferencesHelper
  
  def domain
    @domain ||= PersonMailer.global_prefs.domain
  end
  
  def server
    @server_name ||= PersonMailer.global_prefs.server_name
  end
  
  def post_notification(post)
    from         "System Notifier <no-reply@#{domain}>"
    recipients   Person.admins.collect { |p| p.email }.join(',')
    new_post = post.approved_by.blank?
    subject      formatted_subject(new_post == true ? "New post" : "Updated post")
    body         "post" => post, "new" => new_post, 
                  "server" => server, "url" => admin_posts_path
  end
  
  def comment_notification(comment)
    from         "System Notifier <no-reply@#{domain}>"
    recipients   Person.admins.collect { |p| p.email }.join(',')
    new_comment = comment.approved_by.blank?
    subject      formatted_subject(new_comment == true ? "New comment" : "Updated comment")
    body         "comment" => comment, "new" => new_comment, 
                 "server" => server, "url" => admin_posts_path
  end
  
  def photo_notification(photo)
    from         "System Notifier <no-reply@#{domain}>"
    recipients   Person.admins.collect { |p| p.email }.join(',')
    new_photo = photo.approved_by.blank?
    subject      formatted_subject(new_photo == true ? "New photo" : "Updated photo")
    body         "photo" => photo, "new" => new_photo, 
                 "server" => server, "url" => admin_posts_path
  end
  
  def topic_notification(topic)
    from         "System Notifier <no-reply@#{domain}>"
    recipients   Person.admins.collect { |p| p.email }.join(',')
    new_topic = topic.approved_by.blank?
    subject      formatted_subject(new_topic == true ? "New topic" : "Updated topic")
    body         "topic" => topic, "new" => new_topic, 
                 "server" => server, "url" => admin_posts_path
  end
  
  def sphinx_error
    from         "System Notifier <no-reply@#{domain}>"
    recipients   "nathan@brandalism.com"
    subject      "Sphinx error"
  end
  
  # def password_reminder(person)
  #   from         "Password reminder <password-reminder@#{domain}>"
  #   recipients   person.email
  #   subject      formatted_subject("Password reminder")
  #   body         "person" => person
  # end
  # 
  # def message_notification(message)
  #   from         "Message notification <message@#{domain}>"
  #   recipients   message.recipient.email
  #   subject      formatted_subject("New message")
  #   body         "server" => server, "message" => message,
  #                "preferences_note" => preferences_note(message.recipient)
  # end
  # 
  # def connection_request(connection)
  #   from         "Contact request <connection@#{domain}>"
  #   recipients   connection.person.email
  #   subject      formatted_subject("Contact request from #{connection.contact.name}")
  #   body         "server" => server,
  #                "connection" => connection,
  #                "url" => edit_connection_path(connection),
  #                "preferences_note" => preferences_note(connection.person)
  # end
  # 
  # def blog_comment_notification(comment)
  #   from         "Comment notification <comment@#{domain}>"
  #   recipients   comment.commented_person.email
  #   subject      formatted_subject("New blog comment")
  #   body         "server" => server, "comment" => comment,
  #                "url" => 
  #                blog_post_path(comment.commentable.blog, comment.commentable),
  #                "preferences_note" => 
  #                   preferences_note(comment.commented_person)
  # end
  # 
  # def wall_comment_notification(comment)
  #   from         "Comment notification <comment@#{domain}>"
  #   recipients   comment.commented_person.email
  #   subject      formatted_subject("New wall comment")
  #   body         "server" => server, "comment" => comment,
  #                "url" => person_path(comment.commentable, :anchor => "wall"),
  #                "preferences_note" => 
  #                   preferences_note(comment.commented_person)
  # end
  # 
  # def email_verification(ev)
  #   from         "Email verification <email@#{domain}>"
  #   recipients   ev.person.email
  #   subject      formatted_subject("Email verification")
  #   body         "server_name" => server,
  #                "code" => ev.code
  # end
  
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
