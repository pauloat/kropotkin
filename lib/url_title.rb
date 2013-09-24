require 'net/https'
require 'opengraph'

class UrlTitle
  include Cinch::Plugin

  def initialize(*args)
    super
  end

  match /https?:\/\/[^'"]+/, use_prefix: false, method: :fetch_title

  def fetch_title(m)
    m.message.scan(/https?:\/\/[^'" #]+/).each do |url|
      resource = OpenGraph.fetch(url)

      debug "Fetching #{url}"

      if resource
        m.reply "#{m.user.nick}: #{resource.title}" if not resource.title.empty?
        m.reply resource.description if not resource.description.empty?
      else
        resource = Net::HTTP.get_response(URI(url))
        if resource.get_fields('Content-Type')[0] =~ /text\/html/
          title = resource.body.gsub(/\n/, ' ').squeeze(' ').scan(/<title>(.*?)<\/title>/)[0][0]
          m.reply "#{m.user.nick}: #{title}" if not title.empty?
        end
      end
    end
  end

end
