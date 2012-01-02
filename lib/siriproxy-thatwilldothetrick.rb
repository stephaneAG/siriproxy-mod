require 'cora'
require 'siri_objects'
require 'open-uri'
require 'url_escape'

class SiriProxy::Plugin::ThatWillDoTheTrick < SiriProxy::Plugin
  def initialize(config)
    #if you have custom configuration options, process them here!
  end

  def process(text) 
#this is the url of your php script - it doesnt have to be local but it does have to be running on a webserver with php
     url = "http://localhost:8888/siri.php"
     url << URLEscape.escape(text)
     response = ""
     open(url) {
        |f|
        response = f.read
     }
     #here it detects of "noresponce" is sent back from the server and if it is it just used the default apple responce
     if( response =~ /noresponce/i)
        val = false 
     else
        val = true
     end
     
     if(val)
        say response
        request_completed 
     end 
     return val 
  end
end
