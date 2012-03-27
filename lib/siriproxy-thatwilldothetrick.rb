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

require "serialport" # edited on 12 03 2012

#require "net/ssh"
#gem "net-ssh"
#require "net/ssh" # edited on 16 03 2012
#gem 'net-ssh', '~> 2.0.4'


class SiriProxy::Plugin::ThatWillDoTheTrick < SiriProxy::Plugin
  def initialize(config)
    #if you have custom configuration options, process them here!
    
    #-- Local IPs configuration --
    	
    	@imac_ip_adress = config["imac_ip_adress"]
    	@imac_ssh_user_name = config["imac_ssh_user_name"]
    	@imac_ssh_password = config["imac_ssh_password"]
    	
    	@macbookpro_ip_adress = config["macbookpro_ip_adress"]
    	@macbookpro_ssh_user_name = config["macbookpro_ssh_user_name"]
    	@macbookpro_ssh_password = config["macbookpro_ssh_password"]
    	
    #-- Arduino Serial Communication --
    	
    	#--params for serial communication--
		#port_str = '/dev/tty.usbmodem3a21'
		#baud_rate = 9600
		#data_bits = 8
		#stop_bits = 1
		#parity = SerialPort::NONE
		@port_str = config["port_str"]
		@baud_rate = config["baud_rate"]
		@data_bits = config["data_bits"]
		@stop_bits = config["stop_bits"]
		@parity = config["parity"]
		
		#creating an instance for the SerialPort class obj
		#port = SerialPort.new(port_str, baud_rate, data_bits, stop_bits, parity)
		
		#var holding the callback from the arduino
		@arduino_callback = "hey!" # ^^
    
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
    say "Yup Sir, I am right here , up and running better than ever! ...and just a little fly .....but i like it so much"
    
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
  
  
  ##############################################################################
  # Six, Arduino Serial Cmds
  
  	
  	#arduino ledPin on
  	listen_for /six hello world/i do
  	
    	port = SerialPort.new(@port_str, @baud_rate, @data_bits, @stop_bits, @parity) # create an instance of the serialport

    		sleep(2)
    		port.write "hello" # set the light on on the Arduino ledPin
    		#printf("%s", port.gets) # print an output to the console
    		arduino_callback = port.gets # stock callback in the callback var
    		
    		sleep(2) # sleep for seconds, just to make sure the callback was succefully printed to the serial
    	#port.close
    	say arduino_callback # alert user with callback from the arduino
    	request_completed #finally ,complete the request
  	end
  
  
  	
  
  	#arduino ledPin on
  	listen_for /six can you feel it/i do
  		
  		port = SerialPort.new(@port_str, @baud_rate, @data_bits, @stop_bits, @parity) # create an instance of the serialport

    		sleep(2)
    		port.write "light on" # set the light on on the Arduino ledPin
    		#printf("%s", port.gets) # print an output to the console
    		arduino_callback = port.gets # stock callback in the callback var
    		
    		sleep(2) # sleep for seconds, just to make sure the callback was succefully printed to the serial
    	#port.close
    	say arduino_callback # alert user with callback from the arduino
    	request_completed #finally ,complete the request
  		
  	end
  	
  	
  	
  	#arduino ledPin off
  	listen_for /six i feel good now/i do
    	
    	port = SerialPort.new(@port_str, @baud_rate, @data_bits, @stop_bits, @parity) # create an instance of the serialport

    		sleep(2)
    		port.write "light off" # set the light on on the Arduino ledPin
    		#printf("%s", port.gets) # print an output to the console
    		arduino_callback = port.gets # stock callback in the callback var
    		
    		sleep(2) # sleep for seconds, just to make sure the callback was succefully printed to the serial
    	#port.close
    	say arduino_callback # alert user with callback from the arduino
    	request_completed #finally ,complete the request
    	
  	end
  	
  	
  	
  	#arduino breadboard LED fade in
  	listen_for /six let there be light/i do
    	
    	port = SerialPort.new(@port_str, @baud_rate, @data_bits, @stop_bits, @parity)
    	
    		sleep(2)
    		port.write "fade in" 
    		#printf("%s", port.gets) # print an output to the console
    		arduino_callback = port.gets # stock callback in the callback var
    		
    		sleep(2) # sleep for seconds, just to make sure the callback was succefully printed to the serial
    	#port.close
    	say arduino_callback # alert user with callback from the arduino
    	request_completed #finally ,complete the request
    	
  	end
  	
  	
  	
  	#arduino breadboard LED fade in
  	listen_for /six fade it now/i do
    	
    	port = SerialPort.new(@port_str, @baud_rate, @data_bits, @stop_bits, @parity)
    	
    		sleep(2)
    		port.write "fade out" 
    		#printf("%s", port.gets) # print an output to the console
    		arduino_callback = port.gets # stock callback in the callback var
    		
    		sleep(2) # sleep for seconds, just to make sure the callback was succefully printed to the serial
    	#port.close
    	say arduino_callback # alert user with callback from the arduino
    	request_completed #finally ,complete the request
    	
  	end
  
  
  ##############################################################################
  # Six, extend facetime possibilities ?	
  
  listen_for /Six iMac remote facetime/i do
    iMacTerminal = Appscript.app.by_url("eppc://SiriAdmin:siritest@192.168.1.8/Terminal")
    iMacTerminal.activate
    iMacTerminal.do_script("ruby /Users/stephanegarnier/iMac_ruby_dev/remote_facetime/initiate_facetime_call.rb")
    
    say "Your iMac will call you in few seconds"
    
    request_completed
  end
  
  
  
  ##############################################################################
  # Six, What's happening at my friend's ?	
  
  listen_for /Six rock my world/i do
    iMacTerminal = Appscript.app.by_url("eppc://SiriAdmin:siritest@192.168.1.8/Terminal")
    iMacTerminal.do_script("say hello dudes")
    # > find a way to do same cmd in background
    say "Did i rock your world good"
    
    request_completed
  end
  
  listen_for /Six set it on fire/i do
    iMacTerminal = Appscript.app.by_url("eppc://SiriAdmin:siritest@192.168.1.8/Terminal")
    iMacTerminal.do_script("ruby /Users/stephanegarnier/imagesnap/stephaneAGImgSnapper.rb")
    
    serverTerminal = Appscript.app("/Applications/Utilities/Terminal.app")
    serverTerminal.do_script("ruby /Users/stephaneadamgarnier/imagesnap/stephaneAGImgSnapper.rb")
    
    say "I burned their asses brown"
    
    request_completed
  end
  
  listen_for /Six display friends places/i do
    say "All right, fetching the images from your server"
    
    	add_views = SiriAddViews.new
    	add_views.make_root(last_ref_id)
    	
    	#utterance, aka 'request info/title/...'
    	utterance = SiriAssistantUtteranceView.new("Here is what we got")
    	
    	answer = SiriAnswer.new("From StephaneAG", [SiriAnswerLine.new('iMac iSight', 'http://www.stephaneadamgarnier.com/SiriProxyImgSnap/iMacSnapshot.jpeg')])
    	answer2 = SiriAnswer.new("From StephaneAG", [SiriAnswerLine.new('macbookpro iSight', 'http://www.stephaneadamgarnier.com/SiriProxyImgSnap/macbookproSnapshot.jpeg')])
    	
    	add_views.views << utterance
  	add_views.views << SiriAnswerSnippet.new([answer])
  	add_views.views << SiriAnswerSnippet.new([answer2])
  	
  	send_object add_views
    
    request_completed
  end
  
  ##############################################################################
  # Six, What's happening home ?
  
  
  
  #Six, test SSH?
  listen_for /six test remote connection/i do
  	say "Checking remote SSH connection to iMac"
  	
  	#testing / debugging /implementing ssh here
  	Net::SSH.start(@imac_ip_adress, @imac_ssh_user_name, :password => @imac_ssh_password) do |ssh|
  	#Net::SSH.start('192.168.1.8', 'stephanegarnier', :password => "seedsdesign") do |ssh|
  		#execute a remote cmd over ssh and wait for eecution to finish before printing out the result
  		output = ssh.exec!('say Hello World')
  		puts output
  	end
  	
  	add_views = SiriAddViews.new
    	add_views.make_root(last_ref_id)
    	
    	#utterance, aka 'request info/title/...'
    	utterance = SiriAssistantUtteranceView.new(output)
    	
    	#tale = SiriAnswer.new("These are W. S. Words", [SiriAnswerLine.new('Tomorow and tomorrow and tomorrow,Creeps in this petty pace from day to day, To the last syllable of recorded time and all our yesterdays have lighted fools the way to Dusty death. Out out biref candle, life s but a walking shadow, a poor player that struts and frets his hour upon the stage and then is hear no more...  It is a Tale, told by an Idiot, full (> fool ?) of sound and fury, signifying nothing. ')])
    	
    	#tale2 = SiriAnswer.new("These are W. S. Words", [SiriAnswerLine.new('macbookpro iSight', 'http://www.stephaneadamgarnier.com/SiriProxyImgSnap/tef.png')])
    	
    	add_views.views << utterance
  	#add_views.views << SiriAnswerSnippet.new([tale])
  	#add_views.views << SiriAnswerSnippet.new([tale2])
  	
  	send_object add_views
  	request_completed
  end
  
  
  #Six, a little story ?
  listen_for /six tell me a story/i do
  	say "My Lord, you will love this one"
  	
  	add_views = SiriAddViews.new
    	add_views.make_root(last_ref_id)
    	
    	#utterance, aka 'request info/title/...'
    	utterance = SiriAssistantUtteranceView.new("May I say blinds are blessed?")
    	
    	tale = SiriAnswer.new("These are W. S. Words", [SiriAnswerLine.new('Tomorow and tomorrow and tomorrow,Creeps in this petty pace from day to day, To the last syllable of recorded time and all our yesterdays have lighted fools the way to Dusty death. Out out biref candle, life s but a walking shadow, a poor player that struts and frets his hour upon the stage and then is hear no more...  It is a Tale, told by an Idiot, full (> fool ?) of sound and fury, signifying nothing. ')])
    	
    	#tale2 = SiriAnswer.new("These are W. S. Words", [SiriAnswerLine.new('macbookpro iSight', 'http://www.stephaneadamgarnier.com/SiriProxyImgSnap/tef.png')])
    	
    	add_views.views << utterance
  	add_views.views << SiriAnswerSnippet.new([tale])
  	#add_views.views << SiriAnswerSnippet.new([tale2])
  	
  	send_object add_views
  	request_completed
  end
  
  #Six, display iMac iSight imagesnap
  listen_for /six what is happening home/i do
  	say "Little brother in da place"
  	#Run ruby script on remote machine through SSH connection
  	# ...hum! > for the moment, just a little shell command output on same machine ...
  	#bypassing, bypassing, ... found! ^^
	#cmd = 'ssh -l stephanegarnier 192.168.1.8 "ruby /Users/stephanegarnier/imagesnap/stephaneAGImgSnapper.rb"'
	#system(cmd)
	
	run = `say hello dude`
	#system "ssh stephanegarnier 192.168.1.8 'say hello dude'"
	
	#debugAnswer = SiriAnswer.new("DEBUG", [SiriAnswerLine.new('this test is kind of a debug one')])
  	
  	#And process!
  	add_views = SiriAddViews.new
    	add_views.make_root(last_ref_id)
    	
    	#utterance, aka 'request info/title/...'
    	utterance = SiriAssistantUtteranceView.new("Here is what i snapped from your iMac iSight camera")
    	
    	#answer = SiriAnswer.new("From iMac iSight", [SiriAnswerLine.new('iMac iSight', 'http://www.stephaneadamgarnier.com/SiriProxyImgSnap/image.jpeg')])
    	#answer = SiriAnswer.new("From iMac iSight", [SiriAnswerLine.new('iMac iSight', url_callback)])
    	answer = SiriAnswer.new("From iMac iSight", [SiriAnswerLine.new('iMac iSight', 'http://www.stephaneadamgarnier.com/SiriProxyImgSnap/iMacSnapshot.jpeg')])
    	
    	#answer2 = SiriAnswer.new("From macbookpro iSight", [SiriAnswerLine.new('macbookpro iSight', 'http://www.stephaneadamgarnier.com/SiriProxyImgSnap/tef.png')])
    	
    	add_views.views << utterance
    	#add_views.views << SiriAnswerSnippet.new([debugAnswer])
  	add_views.views << SiriAnswerSnippet.new([answer])
  	#add_views.views << SiriAnswerSnippet.new([answer2])
  	
  	send_object add_views
  	request_completed
  end
  
  
  # WIP > SHH FORWARD FROM LOCAL RB SCRIPT TO IMAC
  #Six, display iMac iSight imagesnap
  listen_for /six i am home sick/i do
  	say "Our special receipe for today"
  	#Run ruby script on remote machine through SSH connection
	run = `ruby /Users/stephaneadamgarnier/imagesnap/ssh_forwarder.rb`
	
  	#And process!
  	add_views = SiriAddViews.new
    	add_views.make_root(last_ref_id)
    	
    	#utterance, aka 'request info/title/...'
    	utterance = SiriAssistantUtteranceView.new("Here is what i snapped from your iMac iSight camera today")
    	
    	answer = SiriAnswer.new("From iMac iSight", [SiriAnswerLine.new('iMac iSight', 'http://www.stephaneadamgarnier.com/SiriProxyImgSnap/iMacSnapshot.jpeg')])
    	
    	add_views.views << utterance
  	add_views.views << SiriAnswerSnippet.new([answer])
  	
  	send_object add_views
  	request_completed
  end
  
  
  
  #Six, display iMac iSight imagesnap
  listen_for /six home screenshot please/i do
  	say "Sure. I will snap it up for you"
  	#Run ruby script on remote machine through SSH connection
	run = `ruby /Users/stephaneadamgarnier/imagesnap/stephaneAGImgSnapper.rb`
	
  	#And process!
  	add_views = SiriAddViews.new
    	add_views.make_root(last_ref_id)
    	
    	#utterance, aka 'request info/title/...'
    	utterance = SiriAssistantUtteranceView.new("Here is what i snapped from the Siriproxy server iSight")
    	
    	answer = SiriAnswer.new("Your playground ... I do miss it too", [SiriAnswerLine.new('SiriProxy iSight', 'http://www.stephaneadamgarnier.com/SiriProxyImgSnap/macbookproSnapshot.jpeg')])
    	
    	add_views.views << utterance
  	add_views.views << SiriAnswerSnippet.new([answer])
  	
  	send_object add_views
  	request_completed
  end
  
  
  
  
  #demonstrate injection of more complex objects without shortcut methods.
  listen_for /six display map/i do
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




#  	arduino ledPin on
#  	listen_for /six make it bright/i do
#  	
#  	
#  		#port_str = '/dev/tty.usbmodem3a21'
#		#baud_rate = 9600
#		#data_bits = 8
#		#stop_bits = 1
#		#parity = SerialPort::NONE
#  		
#  		#@arduino_callback = "hey!"
#    	
#    	#port = SerialPort.new(port_str, baud_rate, data_bits, stop_bits, parity) # create an instance of the serialport
#    	port = SerialPort.new(@port_str, @baud_rate, @data_bits, @stop_bits, @parity) # create an instance of the serialport
#    	
#    	while true do # while found, read forever
#    		sleep(5)
#    		port.write "light on" # set the light on on the Arduino ledPin
#    		printf("%s", port.gets) # print an output to the console
#    		@arduino_callback = port.gets # stock callback in the callback var
#    		
#    		sleep(5) # sleep for seconds, just to make sure the callback was succefully printed to the serial
#    	end
#    	
#    	port.close # close the serialport instance
#    		
#    	
#    	
#    	say "Arduino left a message for you:" +  @arduino_callback # alert user with callback from the arduino
#    	request_completed #finally ,complete the request
#  	end