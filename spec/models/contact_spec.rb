
require 'rails_helper'

RSpec.describe Contact, type: :model do
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:cpf) }
  it { should validate_presence_of(:phone) }
  it { should validate_presence_of(:address) }
  it { should validate_presence_of(:postalcode) }

  describe 'cpf validations' do
    let(:user) { create(:user) }

    it 'validates uniqueness of cpf per user' do
      existing_contact = create(:contact, cpf: '12345678900', user: user)
      new_contact = build(:contact, cpf: '12345678900', user: user)

      expect(new_contact).to_not be_valid
      expect(new_contact.errors[:cpf]).to include('já está em uso')
    end
  end
end
