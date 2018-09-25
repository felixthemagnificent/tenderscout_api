class IndustryCode < ApplicationRecord
  include Pageable
  belongs_to :industry

  def self.search_codes(code)
    results = TenderCodesIndex.query(match:{ code: code} )
    count = results.count
    results = results.objects.page(paginate_params[:page]).per(paginate_params[:page_size])
    render json: {data: results, count: count}
  end
end
