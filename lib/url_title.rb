require 'net/https'
require 'pry'

class UrlTitle
  include Cinch::Plugin

  def initialize(*args)
    super
  end

  match /https?:\/\/[^'"]+/, use_prefix: false, method: :fetch_title

  def fetch_title(m)
    m.message.scan(/https?:\/\/[^'" ]+/).each do |url|
      res = Net::HTTP.get_response(URI(url))

      debug "Fetching #{url}"

      if res.get_fields('Content-Type')[0] =~ /text\/html/
        title = res.body.scan(/<title>(.*?)<\/title>/)[0][0]
        m.reply "#{m.user.nick}: #{title}" if not title.empty?
      end
    end
  end

end
