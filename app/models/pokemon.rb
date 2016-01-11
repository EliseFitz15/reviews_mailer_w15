class Pokemon < ActiveRecord::Base
  belongs_to :user
  has_many :reviews
  
  validates :name, presence: true
  validates :ability, presence: true
  validates :poketype, presence: true
end
