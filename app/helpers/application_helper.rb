module ApplicationHelper
  def document_title
    if @title.present?
      "#{@title} - BAUKIS"
    else
      'BAUKIS'
    end
  end
end
