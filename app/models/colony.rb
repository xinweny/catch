class Colony < ApplicationRecord
  has_many :cats
  has_many :associations, dependent: :destroy
  has_many :users, through: :associations

  validates :name, presence: true
  validates :address, presence: true
end
