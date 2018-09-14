module Sortable
  extend ActiveSupport::Concern

  included do
    def self.sort_by(params)
      field = params[:sort].to_sym
      direction = params[:order].to_sym if %w(asc desc).include? params[:order]
      unless field.blank? or direction.blank?
        order(field => direction)
      end
    end
  end
end