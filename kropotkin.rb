require 'cinch'
require './lib/humanize'
require './lib/url_title'
require './lib/empathy'

kropotkin = Cinch::Bot.new do
  configure do |c|
    c.nick = "Zorakbot"
    c.server = "irc.hackcoop.com.ar"
    c.port = 6697
    c.ssl.use = true
    c.channels = [ "#test", "#Zorak" ]
    c.plugins.plugins = [ UrlTitle, Empathy ]
  end

  # Saludar
  on :message, /^o\// do |m|
    m.reply "o/"
  end

  # Corregir
  # bug
  on :message, /bug/ do |m|
    m.reply "patches welcome", true
  end

  # Corregir
  # open source
  on :message, /open ?source/ do |m|
    m.reply "no querrás decir software libre?", true
  end
end

kropotkin.start
