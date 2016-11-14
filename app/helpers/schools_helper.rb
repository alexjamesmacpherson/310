module SchoolsHelper
  # Returns the Gravatar for the given school.
  def gravatar_school(school, size: 80, padding: size/(20/3))
    if !school.email.nil? && school.email != ""
      gravatar_id = Digest::MD5::hexdigest(school.email.downcase)
      gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
      image_tag(gravatar_url, alt: school.name, class: "gravatar")
    else
      "<div class='gravatar center' style='width:#{size}px;height:#{size}px;font-size:#{size/2}px;padding-top:#{padding}px;background-color:#428bca'>#{school.name.split[0][0]}</div>".html_safe
    end
  end
end
