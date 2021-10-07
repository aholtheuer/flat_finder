class SearchParam < ApplicationRecord
  belongs_to :user
  has_many :search_param_flats
  has_many :flats, through: :search_param_flats
  validates :title, presence: true, length: {minimum: 3, maximum: 105}
end
