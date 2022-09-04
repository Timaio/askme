module QuestionsHelper
  def render_with_hashtags(text)
    text.gsub(/(?:#([\wа-яё]+))/i) { hashtag_link($1) }.html_safe
  end  

  def hashtag_link(hash)
    link_to "##{hash}", search_path(query: hash)
  end
end
