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

FactoryGirl.define do
  factory :goal do
    body "MyString"
user_id 1
public false
  end

end
