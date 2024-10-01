require 'irb/completion'      # [tab][tab]
require "awesome_print"
AwesomePrint.irb!

# configure autocomplete dialog colors
if defined? Reline::Face
  Reline::Face.config(:completion_dialog) do |conf|
    conf.define(:default, foreground: "#cad3f5", background: "#363a4f")
    conf.define(:enhanced, foreground: "#cad3f5", background: "#5b6078")
    conf.define(:scrollbar, foreground: "#c6a0f6", background: "#181926")
  end
  IRB.conf[:COMPLETOR] = :type
else
  IRB.conf[:USE_AUTOCOMPLETE] = false
end

IRB.conf[:EVAL_HISTORY] = 1_000
IRB.conf[:HISTORY_FILE] = "#{Dir.home}/.irb_history.log"

rails_env = "🤗"
if ENV['RAILS_ENV'] == 'production'
  rails_env = "production 🥶"
elsif ENV['RAILS_ENV'] == 'staging'
  rails_env = "staging 🧘"
end

IRB.conf[:PROMPT][:RAILS_APP] = {
  :PROMPT_I=>"#{rails_env} %N(%m):%03n> ",
  :PROMPT_S=>"#{rails_env} %N(%m):%03n%l ",
  :PROMPT_C=>"#{rails_env} %N(%m):%03n* ",
  :RETURN=>"#{rails_env} => %s\n"
}
IRB.conf[:PROMPT_MODE] = :RAILS_APP

