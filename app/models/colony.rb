class Colony < ApplicationRecord
  before_destroy :remove_colony_from_cats

  has_many :cats
  has_many :associations, dependent: :destroy
  has_many :users, through: :associations
  has_many :events, dependent: :destroy

  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :address, presence: true

  mount_uploader :photo, PhotoUploader

  include PgSearch
  multisearchable against: %i[name description address]

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  def admins
    admin_associations = associations.select { |association| association.admin == true }
    admins = admin_associations.map(&:user)

    return admins
  end

  def non_admins
    non_admin_associations = associations.select { |association| association.admin == false }
    non_admins = non_admin_associations.map(&:user)

    return non_admins
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

  def has_cats?(status_index)
    selected_cats = cats.select { |cat| cat.status == Cat.statuses.keys[status_index] }

    return true if Cat.statuses.keys[status_index] == 4 && selected_cats.length == cats.length

    !selected_cats.empty?
  end

  private

  def remove_colony_from_cats
    cats.each do |cat|
      cat.colony = nil
      cat.save
    end
  end
end
