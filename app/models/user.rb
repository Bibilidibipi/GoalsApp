# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  username        :string           not null
#  password_digest :string           not null
#  session_token   :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class User < ActiveRecord::Base
  validates :username, :password_digest, :session_token, presence: true
  validates :username, uniqueness: true
  validates :password, length: { minimum: 6, allow_nil: true }

  has_many :goals
  has_many :comments, as: :commentable
  has_many(
    :authored_comments,
    class_name: :Comment,
    foreign_key: :author_id,
    inverse_of: :author
  )

  attr_reader :password

  before_validation :ensure_session_token

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(password_digest).is_password?(password)
  end

  def reset_session_token!
    self.session_token = generate_session_token
    self.save!
    self.session_token
  end

  def self.find_by_credentials(username, password)
    user = User.find_by_username(username)
    return nil unless user
    user.is_password?(password) ? user : nil
  end

  private

  def generate_session_token
    begin
      s_token = SecureRandom.urlsafe_base64(16)
    end while User.pluck(:session_token).include?(s_token)
    s_token
  end

  def ensure_session_token
    self.session_token ||= generate_session_token
  end
end
