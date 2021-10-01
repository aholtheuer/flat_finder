class SearchParam < ApplicationRecord
  belongs_to :user
  validates :title, presence: true, length: {minimum: 3, maximum: 105}
end
