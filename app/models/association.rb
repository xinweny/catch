class Association < ApplicationRecord
  belongs_to :colony
  belongs_to :user
end
