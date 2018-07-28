module QuestionsHelper
  def render_with_hashtags(content)
    content.gsub(/#\w+/){|word| link_to word, "/questions/hashtag/#{word.delete('#')}"}.html_safe
  end  
end
