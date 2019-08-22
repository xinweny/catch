class Association < ApplicationRecord
  belongs_to :colony
  belongs_to :user

  validates :colony_id, presence: true
  validates :user_id, presence: true
end
