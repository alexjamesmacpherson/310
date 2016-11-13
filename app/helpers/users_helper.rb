module UsersHelper
  # Returns the Gravatar for the given user.
  def gravatar_for(user, size: 80, padding: 22)
    if current_school.gravatar && user.gravatar
      gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
      gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
      image_tag(gravatar_url, alt: user.name, class: "gravatar")
    else
      colours = ["#428bca", "#5cb85c", "#5bc0de", "#f0ad4e", "#d9534f"]
      #image_tag("user-img.jpg", size: size, alt: user.name, class: "gravatar")
      "<div class='gravatar center' style='width:#{size}px;height:#{size}px;font-size:#{size/2}px;padding-top:#{size/(20/3)}px;background-color:#{colours[user.color - 1]}'>#{user.name.split[0][0]}#{user.name.split[1][0]}</div>".html_safe
    end
  end
end
