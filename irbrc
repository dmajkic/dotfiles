require "rubygems"
require "awesome_print"
require 'irb/completion'      # [tab][tab]
require 'map_by_method'       # requires map_by_method gem (http://snipr.com/30q36)
require 'what_methods'        # requires the what_methods gem
require 'hirb'

ENV['IRB_HISTORY_FILE'] = "%USERPROFILE%\\\\.irb_history"
Hirb.enable

# Return a list of methods defined locally for a particular object.  Useful
# for seeing what it does whilst losing all the guff that's implemented
# by its parents (eg Object).
# See comments here: http://drnicwilliams.com/2006/10/12/my-irbrc-for-consoleirb/
class Object
  def local_methods(obj = self)
    obj.methods(false).sort
  end
end

# awesome_print ap
unless IRB.version.include?('DietRB')
  IRB::Irb.class_eval do
    def output_value
      ap @context.last_value
    end
  end
else # MacRuby
  IRB.formatter = Class.new(IRB::Formatter) do
    def inspect_object(object)
      object.ai
    end
  end.new
end

# marker
puts ".irbrc successfully loaded"
