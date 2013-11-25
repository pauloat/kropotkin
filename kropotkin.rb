# encoding: utf-8
require 'cinch'
require './lib/humanize'
require './lib/url_title'
require './lib/empathy'
require './lib/invite.rb'

kropotkin = Cinch::Bot.new do
  configure do |c|
    c.nick = "kropotkin"
    c.server = "irc.hackcoop.com.ar"
    c.port = 6697
    c.ssl.use = true
    c.channels = [ "#test", "#lab" ]
    c.plugins.plugins = [ UrlTitle, Empathy, AcceptInvite ]
  end

  # Saludar
  on :message, /(\s|^)(\\o|o\/)/i do |m|
    m.reply ["o/", '\o'].sample
  end

  on :message, /bug/ do |m|
    m.reply "patches welcome", true
  end

  # Corregir
  on :message, /open ?source/ do |m|
    m.reply "no querrás decir software libre?", true
  end
end

kropotkin.start
