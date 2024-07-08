require 'rails_helper'

RSpec.describe "Contacts", type: :feature do
  let(:user) { create(:user) }
  let(:contact) { create(:contact, user: user) }

  before do
    login_as(user, scope: :user)
  end

  describe "User creates a new contact" do
    it "creates a new contact" do
      visit new_contact_path

      fill_in "Nome", with: "Test Contact"
      fill_in "CPF", with: "12345678901"
      fill_in "Telefone", with: "123456789"
      fill_in "address", with: "Test Address"
      fill_in "postalcode", with: "12345678"
      fill_in "latitude", with: "12.34"
      fill_in "longitude", with: "56.78"

      click_button "Save"

      expect(page).to have_content("Contact was successfully created.")
      expect(Contact.last.name).to eq("Test Contact")
    end
  end

  describe "User deletes a contact" do
    it "destroys the requested contact" do
      contact
      visit contacts_path

      within("#contact_#{contact.id}") do
        click_link "Destroy"
      end

      expect(page).to have_content("Contact was successfully destroyed.")
      expect(Contact.exists?(contact.id)).to be_falsey
    end
  end
end
