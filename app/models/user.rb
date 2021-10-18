class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  before_save {self.email = email.downcase}
  has_many :search_param, dependent: :destroy
  # validates :username, presence: true, length: {minimum: 3, maximum: 25}, uniqueness: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: {minimum: 3, maximum: 105},
                   uniqueness: true,
                   format:     {with: VALID_EMAIL_REGEX}
  #has_secure_password
end
