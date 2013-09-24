# encoding: utf-8
require 'net/https'
require 'opengraph'
require 'cgi'

class UrlTitle
  include Cinch::Plugin

  def initialize(*args)
    super
  end

  match /https?:\/\/[^'"]+/, use_prefix: false, method: :fetch_title

  def fetch_title(m)
    m.message.scan(/https?:\/\/[^'" #]+/).each do |url|
      url = URI.encode(url)
      uri = URI(url)

      # Ignorar lo que no sea html
      Net::HTTP.start uri.host, uri.port, :use_ssl => uri.scheme == 'https' do |http|
        if not http.head(uri.path)['content-type'] =~ /text\/html/
          return
        end
      end

      resource = OpenGraph.fetch(url)

      debug "Fetching #{url}"

      if resource
        m.reply "#{m.user.nick}: #{CGI.unescapeHTML(resource.title)}" if not resource.title.empty?
        m.reply resource.description if not resource.description.empty?
      else
        title = Net::HTTP.get(uri).gsub(/\n/, ' ').squeeze(' ').scan(/<title>(.*?)<\/title>/)[0][0]
        m.reply "#{m.user.nick}: #{CGI.unescapeHTML(title)}" if not title.empty?
      end
    end
  end

end
