require 'erb'

desc "Install blank"
task :install => 'install:all'

DAEMON_INSTALL_DIR = ENV['PREFIX'] || "/usr/local/bin"

namespace :install do
  task :all => [ :prompt, :daemon, :agent, :done ]

  task :prompt do
    puts "\e[1m\e[32mdotjs\e[0m"
    puts "\e[1m-----\e[0m"
    puts "I will install:", ""
    puts "1. blankd(1) in #{DAEMON_INSTALL_DIR}"
    puts "2. com.brnbw.blankd.plist in ~/Library/LaunchAgents",""
    print "Ok? (y/n) "

    begin
      until %w( k ok y yes n no ).include?(answer = $stdin.gets.chomp.downcase)
        puts "(psst... please type y or n)"
        puts "Install dotjs? (y/n)"
      end
    rescue Interrupt
      exit 1
    end

    exit 1 if answer =~ /n/
  end

  task :done do
    if system("curl -k http://localhost:4339 &> /dev/null")
      puts "\e[1m\e[32mblankd installation worked\e[0m"
      puts "now set your safari homepage to http://localhost:4339"
    else
      puts "\e[31mblankd installation failed\e[0m"
      puts "check console.app or open an issue"
    end
  end

  desc "Install launch agent"
  task :agent do
    plist = "com.brnbw.blankd.plist"
    agent_dir = File.expand_path("~/Library/LaunchAgents/")
    agent = File.join(agent_dir, plist)
    Dir.mkdir(agent_dir) unless File.exists?(agent_dir)
    File.open(agent, "w") do |f|
      f.puts ERB.new(IO.read(plist)).result(binding)
    end

    chmod 0644, agent
    puts "starting blankd..."
    sh "launchctl load -w #{agent}"
    # wait for server to start
    sleep 5
  end

  desc "Install dotjs daemon"
  task :daemon => :install_dir_writeable do
    cp "blankd", DAEMON_INSTALL_DIR, :verbose => true, :preserve => true
  end
end

desc "Uninstall dotjs"
task :uninstall => 'uninstall:all'

namespace :uninstall do
  task :all => [ :prompt, :daemon, :agent, :done ]

  task :prompt do
    puts "\e[1m\e[32mdotjs\e[0m"
    puts "\e[1m-----\e[0m"
    puts "I will remove:", ""
    puts "1. blankd(1) from #{DAEMON_INSTALL_DIR}"
    puts "2. com.brnbw.blankd from ~/Library/LaunchAgents"
    print "Ok? (y/n) "

    begin
      until %w( k ok y yes n no ).include?(answer = $stdin.gets.chomp.downcase)
        puts "(psst... please type y or n)"
        puts "Uninstall dotjs? (y/n)"
      end
    rescue Interrupt
      exit 1
    end

    exit 1 if answer =~ /n/
  end

  task :done do
    if system("curl http://localhost:4339 &> /dev/null")
      puts "\e[31mblankd uninstall failed\e[0m"
      puts "blankd is still running"
    else
      puts "\e[1m\e[32mblankd uninstall worked\e[0m"
    end
  end

  desc "Uninstall launch agent"
  task :agent do
    plist = "com.brnbw.blankd.plist"
    agent = File.expand_path("~/Library/LaunchAgents/#{plist}")
    sh "launchctl unload #{agent}"
    rm agent, :verbose => true
  end

  desc "Uninstall dotjs daemon"
  task :daemon => :install_dir_writeable do
    rm File.join(DAEMON_INSTALL_DIR, "blankd"), :verbose => true
  end
end

# Check write permissions on DAEMON_INSTALL_DIR
task :install_dir_writeable do
  if not File.writable?(DAEMON_INSTALL_DIR)
    abort "Error: Can't write to #{DAEMON_INSTALL_DIR}. Try again using `sudo`."
  end
end
