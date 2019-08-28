class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :participations, dependent: :destroy
  has_many :events, through: :participations
  has_many :associations, dependent: :destroy
  has_many :colonies, through: :associations

  mount_uploader :photo, PhotoUploader

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :phone_number, presence: true
  validates :age, numericality: { only_integer: true }

  include PgSearch
  multisearchable against: %i[first_name last_name description]

  def full_name
    "#{first_name.capitalize} #{last_name.capitalize}"
  end

  def admin_groups
    admin_associations = associations.select { |association| association.admin == true }
    colonies = admin_associations.map(&:colony)
    return colonies
  end

  def is_admin?(colony)
    colony.admins.include?(self)
  end
end
