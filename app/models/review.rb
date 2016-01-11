class Review < ActiveRecord::Base
  belongs_to :user
  belongs_to :pokemon

  validates :body, presence: true
  validates :rating, numericality: {
    greater_than_or_equal_to: 1,
    less_than_or_equal_to: 5
  }
  validates :pokemon, presence: true
  validates :user, presence: true
end
