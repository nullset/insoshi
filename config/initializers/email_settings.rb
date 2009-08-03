begin
  unless test?
    global_prefs = Preference.find(:first)
    if global_prefs.email_notifications?
      # ActionMailer::Base.delivery_method = :smtp
      # ActionMailer::Base.smtp_settings = {
      #   :address    => global_prefs.smtp_server,
      #   :port       => 25,
      #   :domain     => global_prefs.domain
      # }
      ActionMailer::Base.delivery_method = :sendmail

      ActionMailer::Base.sendmail_settings = {
        :location       => '/usr/sbin/sendmail',
        :arguments      => '-i -t'
      }
    end
  end
rescue
  # Rescue from the error raised upon first migrating
  # (needed to bootstrap the preferences).
  nil
end