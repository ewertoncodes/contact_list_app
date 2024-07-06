require 'rails_helper'

RSpec.feature 'User Authentication', type: :feature do
  scenario 'user signs up successfully' do
    visit new_user_registration_path
    fill_in 'Email', with: 'test@example.com'
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'
    click_button 'Sign up'

    expect(page).to have_content('Welcome! You have signed up successfully.')
  end

  scenario 'user fails to sign up with invalid data' do
    visit new_user_registration_path
    fill_in 'Email', with: 'invalid_email'
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'
    click_button 'Sign up'

    expect(page).to have_content('Email is invalid')
  end

  scenario 'user logs in successfully' do
    user = create(:user)

    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'

    expect(page).to have_content('Signed in successfully.')
  end

  scenario 'user fails to log in with incorrect credentials' do
    user = create(:user)
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: 'wrong_password'
    click_button 'Log in'

    expect(page).to have_content('Invalid Email or password.')
  end

  scenario 'user logs out successfully' do
    user = create(:user)

    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'

    click_button 'Logout'
    sleep 1

    visit root_path

    expect(page).not_to have_content('Signed out successfully.')
  end


  scenario 'user resets password successfully' do
    user = create(:user)

    visit new_user_session_path
    click_link 'Forgot your password?'

    fill_in 'Email', with: user.email
    click_button 'Send me reset password instructions'

    expect(page).to have_content('You will receive an email with instructions on how to reset your password in a few minutes.')
  end
end
