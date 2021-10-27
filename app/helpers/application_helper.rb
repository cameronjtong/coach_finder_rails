module ApplicationHelper
  def full_title(page_title = nil)
    if page_title.nil?
      'Coach Matcher'
    else
      "#{page_title} | Coach Matcher"
    end
  end
end
