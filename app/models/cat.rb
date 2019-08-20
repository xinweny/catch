class Cat < ApplicationRecord
  belongs_to :colony

  mount_uploader :photo, PhotoUploader

  enum status: %i[spotted trapped at_vet neutered released adopted deceased]

  validates :name, presence: true
  validates :description, presence: true
  validates :status, presence: true
end