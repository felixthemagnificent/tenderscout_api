class Comment < ApplicationRecord
  belongs_to :commentable, polymorphic: true
  belongs_to :user
  has_many :childrens, class_name: 'Comment', foreign_key: "parent_id"
end
