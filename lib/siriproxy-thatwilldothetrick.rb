require 'cora'
require 'siri_objects'
require 'open-uri'
require 'pp'
require 'url_escape'

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

  listen_for /six are you awake/i do
    say "Yup , I am here , up and running better than ever!" #say something to the user!
    
    request_completed #always complete your request! Otherwise the phone will "spin" at the user!
  end
  
  #Demonstrate that you can have Siri say one thing and write another"!
  listen_for /six what is I go to sleep/i do
    say "Sometimes I don't mean it ...", spoken: "Sometimes I want to fuck"
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

