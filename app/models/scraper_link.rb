class ScraperLink < ApplicationRecord
  enum status: [:pending, :done]
end
