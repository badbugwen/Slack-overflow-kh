module QuestionsHelper
  def render_with_hashtags(question)
    question.content.gsub(/#\w+/){
    |word| link_to word, "/questions/hashtag/#{word.delete('#')}" if question.tags.find_by(name: word.downcase.delete('#'))
    }.html_safe
  end  
end
