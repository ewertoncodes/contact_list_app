class User < ApplicationRecord
  validates :email, uniqueness: true

  has_many :contacts, dependent: :destroy
  accepts_nested_attributes_for :contacts

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
