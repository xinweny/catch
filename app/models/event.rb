class Event < ApplicationRecord
  belongs_to :colony
  has_many :participations, dependent: :destroy
  has_many :users, through: :participations

  enum phase: %i[trap neuter release check_up]

  validates :title, presence: true
  validates :address, presence: true
  validates :start, presence: true
  validates :end, presence: true
  validates :phase, presence: true
end
