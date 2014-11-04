require "rubygems"
require "awesome_print"

#Pry.config.commands.import Pry::ExtendedCommands::Experimental
#Pry.config.pager = false
Pry.config.color = true
#Pry.config.history.should_save = false

Pry.print = proc { |output, value| output.puts value.ai } # awesome_print umesto print


