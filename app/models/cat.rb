class Cat < ApplicationRecord
  belongs_to :colony, optional: true

  mount_uploader :photo, PhotoUploader
  has_paper_trail on: %i[create update destroy]

  enum status: %i[spotted trapped at_vet neutered released adopted deceased]
  enum sex: %i[male female unknown]

  validates :name, presence: true
  validates :description, presence: true
  validates :address, presence: true
  validates :status, presence: true
  validates :sex, presence: true

  geocoded_by :address

  after_validation :geocode, if: :will_save_change_to_address?

  def last_version
    versions.last
  end

  def all_changes
    return {} if last_version.nil?

    changes = last_version.changeset.except(:updated_at, :colony_id, :longitude, :latitude)
    changes.each do |attribute, change|
      changes.delete(attribute) if change == [nil, ""]
    end
    return changes
  end

  def last_updated
    last_version.changeset[:updated_at][1]
  end
end
