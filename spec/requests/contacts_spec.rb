# spec/requests/contacts_spec.rb

require 'rails_helper'

RSpec.describe "Contacts", type: :request do
  describe "GET /contacts" do
    it "renders a successful response" do
      user = create(:user) # Usar FactoryBot ou criar manualmente um usuário
      sign_in user

      get contacts_path
      expect(response).to be_successful
    end
  end

  describe "POST /contacts" do
    it "creates a new contact" do
      user = create(:user) # Usar FactoryBot ou criar manualmente um usuário
      sign_in user

      expect {
        post contacts_path, params: { contact: attributes_for(:contact) }
      }.to change(user.contacts, :count).by(1)

      expect(response).to redirect_to(contact_path(Contact.last))
    end
  end

  describe "PATCH /contacts/:id" do
    it "updates the requested contact" do
      user = create(:user)
      contact = create(:contact, user: user)
      sign_in user

      patch contact_path(contact), params: { contact: { name: "New Name" } }
      contact.reload

      expect(contact.name).to eq("New Name")
      expect(response).to redirect_to(contact_path(contact))
    end
  end

  describe "DELETE /contacts/:id" do
    it "destroys the requested contact" do
      user = create(:user)
      contact = create(:contact, user: user)
      sign_in user

      expect {
        delete contact_path(contact)
      }.to change(user.contacts, :count).by(-1)

      expect(response).to redirect_to(contacts_path)
    end
  end
end
