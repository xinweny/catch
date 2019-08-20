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
end
