require 'rails_helper'

feature 'User signup flow' do
  before { visit root_path }

  scenario 'user is instructed to sign up on homepage' do
    expect(page).to have_content 'Welcome, please click the sign up or sign in links below'
  end

  scenario 'takes the user to a sign in form from the root path via link' do
    click_link 'Sign up'

    expect(current_path).to eq '/sign-up'
    expect(page).to have_content 'Sign Up Form'
  end

  scenario 'allows a user to sign up (sans validations)' do
    click_link 'Sign up'
    fill_in :user_email, with: 'testMcTesterson@example.com'
    fill_in :user_password, with: 'password'
    fill_in :user_password_confirmation, with: 'password'
    click_button 'Create User'

    expect(current_path).to eq '/shovels'
    expect(page).to have_content 'List of Shovels'
    expect(page).to have_content 'Successfully signed up'
  end
end
