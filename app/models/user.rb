class User < ApplicationRecord
  has_many :search_param
  validates :username, presence: true, length: {minimum: 3, maximum: 25}, uniqueness: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: {minimum: 3, maximum: 105},
                   uniqueness: true,
                   format:     {with: VALID_EMAIL_REGEX}
  has_secure_password
end
