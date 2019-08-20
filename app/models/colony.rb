class Colony < ApplicationRecord
  has_many :cats
  has_many :associations, dependent: :destroy
  has_many :users, through: :associations
  has_many :events, dependent: :destroy

  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :address, presence: true
  validates :radius, presence: true, numericality: true

  def admins
    admin_associations = associations.select { |association| association.admin == true }
    admins = admin_associations.map(&:user)

    return admins
  end
end
