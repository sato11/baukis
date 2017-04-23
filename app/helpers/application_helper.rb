module ApplicationHelper
  include HtmlBuilder

  def document_title
    if @title.present?
      "#{@title} - BAUKIS"
    else
      'BAUKIS'
    end
  end
end
