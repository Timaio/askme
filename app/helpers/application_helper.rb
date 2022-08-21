module ApplicationHelper
  def incline(count, singular, plural)
    count == 1 ? singular : plural
  end
end
