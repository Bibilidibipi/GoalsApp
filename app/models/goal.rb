# == Schema Information
#
# Table name: goals
#
#  id         :integer          not null, primary key
#  body       :string           not null
#  user_id    :integer          not null
#  public     :boolean          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  completed  :boolean          default(FALSE), not null
#

class Goal < ActiveRecord::Base
  validates :body, :user_id, presence: true
  validates :public, :completed, inclusion: { in: [true, false] }

  belongs_to :user
  has_many :comments, as: :commentable
end
