require_relative "bot/version"

require 'rubygems'
require 'twitter'

class Connexion

	def connect	
		client = Twitter::Streaming::Client.new do |config|
			config.consumer_key        = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
			config.consumer_secret     = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
			config.access_token        = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
			config.access_token_secret = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
		end
	end
end

class Connexion2

	def connect2
		client = Twitter::REST::Client.new do |config|
			config.consumer_key        = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
			config.consumer_secret     = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
			config.access_token        = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
			config.access_token_secret = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
		end
	end
end

module Twitter
	def Listen
		link = Connexion.new
		link2 = Connexion2.new
		connect = link.connect
		connect2 = link2.connect2
		tab = Hash.new
		tab = {"hello" => "Hello GUY!!!", 
			"bien?" => "trankillement", 
			"Gecko" => "c des mini lézard", 
			"formation" => "j'apprends kedal", 
			"paul" => "Merci pour les bonus", 
			"nom ?" => "Pascal the BEST",
			"php" => "C'est de la merde",
			"ruby" => "I love Ruby",
			"JS" => "C'est de la balle!!!"}


			connect.user do |object|
				case object
				when Twitter::Tweet
					puts "Tweet:@#{object.user.screen_name}:#{object.text}"
				when Twitter::DirectMessage
					puts "DM:@#{object.sender.screen_name}:#{object.text}"
					tab.each {|k,v| 
						if object.text == k
							connect2.create_direct_message("@#{object.sender.screen_name}", "#{v}")
						end
					}
				when Twitter::Streaming::StallWarning
					warn "Falling behind!"
				end
			end
		end
	end

	class Includer
		include Twitter
	end

	toto = Includer.new

	toto.Listen