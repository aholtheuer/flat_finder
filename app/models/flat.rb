class Flat < ApplicationRecord
  has_many :search_param_flats
  has_many :search_params, through: :search_param_flats
  validates :href, uniqueness: true, presence: true
end
