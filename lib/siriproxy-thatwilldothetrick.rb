require 'cora'
require 'siri_objects'
require 'open-uri'
require 'pp'
require 'url_escape'
require 'rubygems' # edited on 08 01 2012
require 'appscript' # edited on 08 01 2012
require 'osax' # edited on 08 01 2012

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
      say "With great pleasure!"
    else
      say "You could have so much fun with me so horny!"
    end
    
    request_completed #always complete your request! Otherwise the phone will "spin" at the user!
  end
  
  
  ##############################################################################
  # Six, remote computing cmds
  
  listen_for /Six Mac songs/i do
    iMaciTunes = Appscript.app.by_url("eppc://SiriAdmin:siritest@192.168.1.13/Finder").application_files.ID("com.apple.iTunes")
      iMaciTunes.open
      
    say "I just launched iTunes for you"
    
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

