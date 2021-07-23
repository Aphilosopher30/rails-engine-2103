class ApplicationController < ActionController::API

  def error_404(errors = ['unidentified error'])
    render json: {id: nil, data: {message: "your query could not be completed", errors: errors}}, :status => 404
  end

  def paginate(page, per_page)
    if page.class != Integer || page < 1
      page = 1
    end
    if per_page.class != Integer || per_page < 1
      per_page = 20
    end
    offset = per_page*(page-1)
    {offset: offset, per_page: per_page}
  end
end
