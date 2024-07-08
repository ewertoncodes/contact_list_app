# spec/queries/contact_search_query_spec.rb
require 'rails_helper'

RSpec.describe ContactSearchQuery, type: :query do
  let(:user) { create(:user) }

  before do
    @contact1 = create(:contact, name: "John Doe", cpf: "12345678901", user: user)
    @contact2 = create(:contact, name: "Jane Smith", cpf: "98765432101", user: user)
    @contact3 = create(:contact, name: "Johnny Appleseed", cpf: "12345098765", user: user)
  end

  it 'returns all contacts when search query is empty' do
    result = ContactSearchQuery.new(user.contacts).search('')
    expect(result).to contain_exactly(@contact1, @contact2, @contact3)
  end

  it 'returns contacts that match the name' do
    result = ContactSearchQuery.new(user.contacts).search('John')
    expect(result).to contain_exactly(@contact1, @contact3)
  end

  it 'returns contacts that match the CPF' do
    result = ContactSearchQuery.new(user.contacts).search('98765432101')
    expect(result).to contain_exactly(@contact2)
  end

  it 'returns contacts that match either name or CPF' do
    result = ContactSearchQuery.new(user.contacts).search('12345678901')
    expect(result).to contain_exactly(@contact1)
  end

  it 'returns an empty array when no contacts match the search query' do
    result = ContactSearchQuery.new(user.contacts).search('Nonexistent')
    expect(result).to be_empty
  end
end
