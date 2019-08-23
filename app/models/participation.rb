class Participation < ApplicationRecord
  belongs_to :event
  belongs_to :user

  validates :event_id, presence: true
  validates :user_id, presence: true
end
