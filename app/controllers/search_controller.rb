class SearchController < ApplicationController
  def index
    query = params[:query].gsub('#', '').downcase
    @questions = Question.joins(:hashtags).where(hashtags: {text: query})
  end
end
