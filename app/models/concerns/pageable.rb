module Pageable
  include ActiveSupport::Concern

  def paginate(page: nil, page_size: nl)
    page(page).per(page_size)
  end
end