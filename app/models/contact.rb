
class Contact < ApplicationRecord
  belongs_to :user

  validates :name, :cpf, :phone, :address, :postalcode, presence: true
  validates :cpf, presence: true, uniqueness: true 
end
