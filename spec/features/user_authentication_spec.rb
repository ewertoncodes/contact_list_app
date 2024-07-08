require 'rails_helper'

RSpec.feature 'User Authentication', type: :feature do
  scenario "User signs up with contact information" do
    visit new_user_registration_path

    fill_in "Email", with: "user@example.com"
    fill_in "Senha", with: "password"
    fill_in "onfirmação de Senha", with: "password"

    within(".nested-fields") do
      fill_in "Nome", with: "João da Silva"
      fill_in "CPF", with: "123.456.789-00"
      fill_in "Telefone", with: "(11) 99999-9999"
      fill_in "address", with: "Rua Exemplo, 123"
      fill_in "postalcode", with: "12345-678"
    end

    click_button "Registrar-se"

    expect(page).to have_content("Bem-vindo! Você se cadastrou com sucesso.")
    new_contact = Contact.last
    expect(new_contact.name).to eq("João da Silva")
    expect(new_contact.cpf).to eq("123.456.789-00")
    expect(new_contact.phone).to eq("(11) 99999-9999")
    expect(new_contact.address).to eq("Rua Exemplo, 123")
    expect(new_contact.postalcode).to eq("12345-678")
  end

  scenario 'user fails to sign up with invalid data' do
    visit new_user_registration_path
    fill_in 'Email', with: 'invalid_email'
    fill_in 'Senha', with: 'password'
    fill_in 'Confirmação de Senha', with: 'password'
    click_button 'Registrar-se'

    expect(page).to have_content('não é válido')
  end

  scenario 'user logs in successfully' do
    user = create(:user)

    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Senha', with: user.password
    click_button 'Log in'

    expect(page).to have_content('Login realizado com sucesso.')
  end

  scenario 'user fails to log in with incorrect credentials' do
    user = create(:user)
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Senha', with: 'wrong_password'
    click_button 'Log in'

    expect(page).to have_content('Email ou senha inválidos.')
  end

  scenario 'user logs out successfully' do
    user = create(:user)

    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Senha', with: user.password
    click_button 'Log in'

    click_button 'Logout'
    sleep 1

    visit root_path

    expect(page).not_to have_content('Signed out successfully.')
  end


  scenario 'user resets password successfully' do
    user = create(:user)

    visit new_user_session_path
    click_link 'Esqueceu sua senha?'

    fill_in 'Email', with: user.email
    click_button 'Você receberá um email com instruções sobre como redefinir sua senha em alguns minutos.'

    expect(page).to have_content('Você receberá um email com instruções sobre como redefinir sua senha em alguns minutos.')
  end
end
