class Empathy
  include Cinch::Plugin

  match /!!/, use_prefix: false, method: :surprise
  def surprise(m)
    m.reply ":O"
  end

  match /:[c\(]/, use_prefix: false, method: :hug
  def hug(m)
    m.channel.action "abraza a #{m.user.nick} :)"
  end

  match /\\o\//, use_prefix: false, method: :cheer
  def cheer(m)
    m.reply "\o/"
  end

end
