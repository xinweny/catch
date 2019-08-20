class Cat < ApplicationRecord
  belongs_to :colony, optional: true
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  mount_uploader :photo, PhotoUploader

  enum status: %i[spotted trapped at_vet neutered released adopted deceased]
  enum sex: %i[male female unknown]

  validates :name, presence: true
  validates :description, presence: true
  validates :address, presence: true
  validates :status, presence: true
  validates :sex, presence: true
end
