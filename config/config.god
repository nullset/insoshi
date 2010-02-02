RAILS_ROOT = "/var/www/community/current"

God.watch do |w|
#    w.uid = 'deployer'
#    w.gid = 'deployer'

    w.name = "ultrasphinx"
    w.interval = 5.seconds # default      
    w.start = "cd #{RAILS_ROOT}; rake ultrasphinx:daemon:stop RAILS_ENV=production; rake ultrasphinx:index:main RAILS_ENV=production; rake ultrasphinx:daemon:start RAILS_ENV=production"
    w.stop = "cd #{RAILS_ROOT}; rake ultrasphinx:daemon:stop RAILS_ENV=production"
    w.restart = "cd #{RAILS_ROOT}; rake ultrasphinx:daemon:stop RAILS_ENV=production; rake ultrasphinx:index:main RAILS_ENV=production; rake ultrasphinx:daemon:start RAILS_ENV=production"
    w.start_grace = 10.seconds
    w.restart_grace = 10.seconds
#    w.pid_file = File.join(RAILS_ROOT, "log/searchd.pid")

  # clean pid files before start if necessary
  w.behavior(:clean_pid_file)
  
  # determine the state on startup
  w.transition(:init, { true => :up, false => :start }) do |on|
    on.condition(:process_running) do |c|
      c.running = true
    end
  end
  
  # determine when process has finished starting
  w.transition([:start, :restart], :up) do |on|
    on.condition(:process_running) do |c|
      c.running = true
    end
    
    # failsafe
    on.condition(:tries) do |c|
      c.times = 5
      c.transition = :start
    end
  end

  # start if process is not running
#  w.transition(:up, :start) do |on|
#    on.condition(:process_exits)
#  end
end