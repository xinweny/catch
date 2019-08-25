class Colony < ApplicationRecord
  before_destroy :remove_colony_from_cats

  has_many :cats
  has_many :associations, dependent: :destroy
  has_many :users, through: :associations
  has_many :events, dependent: :destroy

  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :address, presence: true
  validates :radius, presence: true, numericality: true

  mount_uploader :photo, PhotoUploader

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  def admins
    admin_associations = associations.select { |association| association.admin == true }
    admins = admin_associations.map(&:user)

    return admins
  end

  def update_cats(ids)
    ids.each do |id|
      cat = Cat.find(id)
      cat.colony = self
      cat.save
    end
  end

  def has_admin?(user)
    user.admin_groups.include?(self)
  end

  private

  def remove_colony_from_cats
    cats.each do |cat|
      cat.colony = nil
      cat.save
    end
  end
end
