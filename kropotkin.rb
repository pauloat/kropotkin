require 'cinch'
require './lib/url_title'
require './lib/empathy'

kropotkin = Cinch::Bot.new do
  configure do |c|
    c.nick = "kropotkin"
    c.server = "irc.hackcoop.com.ar"
    c.port = 6697
    c.ssl.use = true
    c.channels = [ "#test", "#lab" ]
    c.plugins.plugins = [ UrlTitle, Empathy ]
  end

  # Saludar
  on :message, /o\// do |m|
    m.reply "o/"
  end

  # Corregir
  on :message, /open ?source/ do |m|
    m.reply "#{m.user.nick}: no querrás decir software libre?"
  end
end

kropotkin.start
