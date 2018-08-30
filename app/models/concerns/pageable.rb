module Pageable
  include ActiveSupport::Concern
  included do
    def my_paginate(params)
      page(params[:page].to_i).per(params[:page_size].to_i)
    end
  end
end