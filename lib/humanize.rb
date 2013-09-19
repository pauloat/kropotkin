# encoding: utf-8
require 'cinch/timer'
# Agregar un temporizador para que las respuestas no sean inmediatas y
# parezca más humano
module Cinch
  class Message
    def human_reply(text, prefix = false)
      text = text.to_s
      if @channel && prefix
        text = text.split("\n").map {|l| "#{user.nick}: #{l}"}.join("\n")
      end

      Timer.new(rand(10), shots: 1) {
        @target.send(text)
      }
    end
  end
end
