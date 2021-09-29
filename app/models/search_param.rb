class SearchParam < ApplicationRecord
  validates :title, presence: true, length: {minimum: 3, maximum: 105}
end
