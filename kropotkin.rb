require 'cinch'
require './lib/url_title'

kropotkin = Cinch::Bot.new do
  configure do |c|
    c.nick = "kropotkin"
    c.server = "irc.hackcoop.com.ar"
    c.port = 6697
    c.ssl.use = true
    c.channels = [ "#test", "#lab" ]
    c.plugins.plugins = [ UrlTitle ]
  end

  on :message, "o/" do |m|
    m.reply "o/"
  end
end

kropotkin.start
