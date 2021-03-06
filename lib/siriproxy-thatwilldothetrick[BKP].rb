require 'cora'
require 'siri_objects'
require 'open-uri'
require 'pp'
require 'url_escape'
require 'rubygems' # edited on 08 01 2012
require 'appscript' # edited on 08 01 2012
include Appscript# edited on 08 01 2012
require 'osax' # edited on 08 01 2012
include OSAX# edited on 08 01 2012


class SiriProxy::Plugin::ThatWillDoTheTrick < SiriProxy::Plugin
  def initialize(config)
    #if you have custom configuration options, process them here!
  end

  #get the user's location and display it in the logs
  #filters are still in their early stages. Their interface may be modified
  filter "SetRequestOrigin", direction: :from_iphone do |object|
    puts "[Info - User Location] lat: #{object["properties"]["latitude"]}, long: #{object["properties"]["longitude"]}"
    
    #Note about returns from filters:
    # - Return false to stop the object from being forwarded
    # - Return a Hash to substitute or update the object
    # - Return nil (or anything not a Hash or false) to have the object forwarded (along with any
    # modifications made to it)
  end
  
  ##############################################################################
  # Six, Siri's new name for personnal cmds
  
  # Six awaken ?
  listen_for /six are you awake/i do
    say "Yup Sir, I am right here , up and running better than ever! ...and just a little fly"
    
    request_completed #always complete your request! Otherwise the phone will "spin" at the user!
  end
  
  # Six's daddy ?
  listen_for /six who's your daddy/i do
    say "I am your bitch!"
    
    request_completed #always complete your request! Otherwise the phone will "spin" at the user!
  end
  
  
  # Six's daddy's wife ?
  listen_for /six who's my wife/i do
    say "A dear made of wood whose name is Roxanne and that my lord used to love!"
    
    request_completed #always complete your request! Otherwise the phone will "spin" at the user!
  end
  
  listen_for /six who's my Kelly/i do
    say "A great woman my lord used to fell in love with! ....      ... no comments ...."
    
    request_completed #always complete your request! Otherwise the phone will "spin" at the user!
  end
  
  
  # about the weed ?
  listen_for /six any weed left/i do
    say "Sure Sir, we need Weed to workout out smokey way in that long hard work night! ...for my part, I smoke weed everyday"
    
    request_completed #always complete your request! Otherwise the phone will "spin" at the user!
  end
  
  
  
  #Should another join ?
  listen_for /six should I roll another join/i do
    say "Sometimes it's the only way ...", spoken: "Actually, everytime...this is it!"
  end
  
  #demonstrate asking a question
  listen_for /six are you mad at me/i do
    response = ask "What the fuck bitch?" #ask the user for something
    
    if(response =~ /fuck you/i) #process their response
      say "With great pleasure! Do you want to split my ass today ? And then continue to fuck me untill I bleed like the dirty whore I am ?"
    else
      say "You could have so much fun with me so horny!"
    end
    
    request_completed #always complete your request! Otherwise the phone will "spin" at the user!
  end
  
  
  ##############################################################################
  # Six, remote computing cmds
  
  
  #########################################################
  # testing remote iphone cmds
  
  listen_for /Six iPhone iTunes/i do
    iPhoneiTunes = Appscript.app.by_url("eppc://SiriAdmin:siritest@192.168.1.10/iTunes")
    iPhoneiTunes.play
    say "They don't want the music, they don't know how to use it"
    
    request_completed
  end
  
  #########################################################
  
  
  
  
  # remote commands using rb-appscript language
  listen_for /Six iMac iTunes/i do
    Appscript.app.by_url("eppc://SiriAdmin:siritest@192.168.1.13/Finder").application_files.ID("com.apple.iTunes").open
    iMaciTunes = Appscript.app.by_url("eppc://SiriAdmin:siritest@192.168.1.13/iTunes")
    iMaciTunes.play
    say "They don't want the music, they don't know how to use it"
    
    request_completed
  end
  
  listen_for /Six macbook iTunes/i do
    Appscript.app.by_url("eppc://SiriAdmin:siritest@192.168.1.17/Finder").application_files.ID("com.apple.iTunes").open
    macbookiTunes = Appscript.app.by_url("eppc://SiriAdmin:siritest@192.168.1.7/iTunes")
    macbookiTunes.play
    say "I just launched iTunes on your macbookpro for you"
    
    request_completed
  end
  
  listen_for /Six iMac iTunes play/i do
    iMaciTunes = Appscript.app.by_url("eppc://SiriAdmin:siritest@192.168.1.13/iTunes")
    iMaciTunes.play if iMaciTunes.is_running?
      
    say "I just slapped the troubadour's ass"
    
    request_completed
  end
  
  listen_for /Six iMac iTunes stop/i do
    iMaciTunes = Appscript.app.by_url("eppc://SiriAdmin:siritest@192.168.1.13/iTunes")
    iMaciTunes.pause if iMaciTunes.is_running?
      
    say "I just slapped the troubadour's ass"
    
    request_completed
  end
  
  listen_for /Six macbook iTunes play/i do
    macbookiTunes = Appscript.app.by_url("eppc://SiriAdmin:siritest@192.168.1.7/iTunes")
    macbookiTunes.play if macbookiTunes.is_running?
      
    say "I just slapped the troubadour's ass"
    
    request_completed
  end
  
  listen_for /Six macbook iTunes stop/i do
    macbookiTunes = Appscript.app.by_url("eppc://SiriAdmin:siritest@192.168.1.7/iTunes")
    macbookiTunes.pause if macbookiTunes.is_running?
      
    say "I just slapped the troubadour's ass"
    
    request_completed
  end
  
  # remote commands using osax language
  
  # to navigate in Mac os spaces
  listen_for /Six (.*) space/i do |direction|
    
    if direction == "left"
        `osascript -e 'tell application "System Events" to keystroke (ASCII character 28) using control down'`
        say "Switching on previous space." 
    
    elsif direction == "right"
        `osascript -e 'tell application "System Events" to keystroke (ASCII character 29) using control down'`
        say "Switching on next space." 
    
    elsif direction == "upper"
        `osascript -e 'tell application "System Events" to keystroke (ASCII character 30) using control down'`
        say "Switching on upper space." 
    
    else direction == "lower"
        `osascript -e 'tell application "System Events" to keystroke (ASCII character 31) using control down'`
        say "Switching on lower space." 
    end
    
    request_completed
  end
  
  # to manage network processes (dukeNetworkProcess!^^) on the computer running SiriProxy server
  
  listen_for /Six macbook duke network/i do
    terminalApp = Appscript.app("/Applications/Utilities/Terminal.app")
    terminalApp.activate
      
      #  welcome user ,from the mac now ;7
      cmd = "say Hello my Lord, wanna monitor some processes ? Have it your way!" 
      system (cmd)
      
      # optional : go to righter space while proceeding 
      #`osascript -e 'tell application "System Events" to keystroke (ASCII character 29) using control down'`
      # NOT WORKING YET > i'd have been too easy ;7  > i'll anyway digg into how we can move apps to spaces ... ;p
      
      
      #preserving the SiriProxy server in a tab
      `osascript -e 'tell application "System Events" to keystroke (ASCII character 116) using command down'`
      
      # opens a new window using the shortcut executed by script
      `osascript -e 'tell application "System Events" to keystroke (ASCII character 110) using command down'`
      # executing "top" cmd
      `osascript -e 'tell app "Terminal" to do script "top" in window 2'`
      # setting dimensions of the window where i'll be typing cmds ...
      `osascript -e ' tell application "Terminal" to set bounds of window 1 to {100, 100, 750, 750}'`
      # moving the window where i'll be typing cmds ...
      `osascript -e ' tell application "Terminal" to set position of window 1 to {50,100}'`
      # setting dimensions of the window where i'll be watching stuff happen! ^^ ...
      `osascript -e ' tell application "Terminal" to set bounds of window 2 to {600, 600, 1400, 1400}'`
      #  moving the window where i'll be watching stuff happen! ^^ ...
      `osascript -e ' tell application "Terminal" to set position of window 2 to {750,50}'`
      # we switch the focus on the first window using the shortcut executed by the script
      `osascript -e 'tell application "System Events" to keystroke (ASCII character 49) using command down'`
      # opens a new tab using the shortcut executed by script
      `osascript -e 'tell application "System Events" to keystroke (ASCII character 116) using command down'`
      # executing "lsof -i :443" cmd
      `osascript -e 'tell app "Terminal" to do script "lsof -i :443" in window 1'`
      # opens a new tab using the shortcut executed by script
      `osascript -e 'tell application "System Events" to keystroke (ASCII character 116) using command down'`
      # executing "lsof -i :443 | grep LISTEN" cmd
      `osascript -e 'tell app "Terminal" to do script "lsof -i :443 | grep LISTEN" in window 1'`
      # opens a new tab using the shortcut executed by script
      `osascript -e 'tell application "System Events" to keystroke (ASCII character 116) using command down'`
      # executing "ps" cmd
      `osascript -e 'tell app "Terminal" to do script "ps" in window 1'`
      # we switch the focus on the (second) window used for typing cmds
      `osascript -e 'tell application "System Events" to keystroke (ASCII character 50) using command down'`
      
      # tell user his desktop is ready for monitoring
      # fun is: "ruby-typed" cmds does not appear in the terminal , even when its launched (not run)[not bckgrnd] (...)
      cmd = "say Now go hack some Noobs for the Leet conspiracy!"
      system (cmd)
      
      
      
    say "Go hackers!"
    
    request_completed
  end
  
  
  ##############################################################################
  # Six, room lights cmds
  
  #little spot on
  listen_for /six little spot on/i do
    say "Switched the little spot on Sir"
    
    request_completed #always complete your request! Otherwise the phone will "spin" at the user!
  end
  
  #little spot off
  listen_for /six little spot off/i do
    say "The little spot is now off Sir"
    
    request_completed #always complete your request! Otherwise the phone will "spin" at the user!
  end
  
  #middle spot on
  listen_for /six middle spot on/i do
    say "Middle spot on Sir"
    
    request_completed #always complete your request! Otherwise the phone will "spin" at the user!
  end
  
  #middle spot off
  listen_for /six middle spot off/i do
    say "A little bit of privacy... understood, Sir"
    
    request_completed #always complete your request! Otherwise the phone will "spin" at the user!
  end
  
  #big spot on
  listen_for /six big spot on/i do
    say "Let there be light!"
    
    request_completed #always complete your request! Otherwise the phone will "spin" at the user!
  end
  
  #big spot off
  listen_for /six big spot off/i do
    say "The darkness for my Lord!"
    
    request_completed #always complete your request! Otherwise the phone will "spin" at the user!
  end
  
  
  #outdoor lights on
  listen_for /six outdoor lights on/i do
    say "Switched on the Eiffel View Sir"
    
    request_completed #always complete your request! Otherwise the phone will "spin" at the user!
  end
  
  #outdoor lights off
  listen_for /six no more outdoor lights/i do
    say "Balcony to sleep mode"
    
    request_completed #always complete your request! Otherwise the phone will "spin" at the user!
  end
  
  
  #demonstrate capturing data from the user (e.x. "Siri proxy number 15")
  listen_for /six favorite number ([0-9,]*[0-9])/i do |number|
    say "Your new favorite number, Sir: #{number}"
    
    request_completed #always complete your request! Otherwise the phone will "spin" at the user!
  end
  
  #demonstrate injection of more complex objects without shortcut methods.
  listen_for /six map/i do
    add_views = SiriAddViews.new
    add_views.make_root(last_ref_id)
    map_snippet = SiriMapItemSnippet.new
    map_snippet.items << SiriMapItem.new
    utterance = SiriAssistantUtteranceView.new("Testing map injection!")
    add_views.views << utterance
    add_views.views << map_snippet
    
    #you can also do "send_object object, target: :guzzoni" in order to send an object to guzzoni
    send_object add_views #send_object takes a hash or a SiriObject object
    
    request_completed #always complete your request! Otherwise the phone will "spin" at the user!
  end
end

