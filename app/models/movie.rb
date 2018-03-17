class Movie < ApplicationRecord
  belongs_to :user
  validates :name, presence: true
  has_many :favorites
  has_many :members, through: :favorites, source: :user
  has_many :comments
end
