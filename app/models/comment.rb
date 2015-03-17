class Comment < ActiveRecord::Base
  validates :body, :author, :commentable_id, :commentable_type, presence: true

  belongs_to :author, class_name: :User, foreign_key: :author_id
  belongs_to :commentable, polymorphic: true
end
