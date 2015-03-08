require 'rails_helper'

feature 'Authenticated user can logout' do
  scenario 'from the shovels index' do
    balsawood = Shovel.new(name: 'Balsawood', quantity: 10)
    balsawood.save!
    sign_in_user

    click_link 'Sign out'

    expect(current_path).to eq root_path
    expect(page).to have_content 'Thank you, come again.'

    visit shovels_path
    expect(page).to have_content 'You must register or log in before you can do that! Fool!'
  end

  scenario 'does not show the logout link on any page other than the shovels index' do
    balsawood = Shovel.new(name: 'Balsawood', quantity: 730)
    balsawood.save!
    sign_in_user

    [root_path, sign_in_path, sign_up_path, new_shovel_path, shovel_path(balsawood), edit_shovel_path(balsawood)]. each do |path|
      visit path

      expect(page).to_not have_content 'Sign out'
    end
  end
end
