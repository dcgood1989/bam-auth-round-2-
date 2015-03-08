require 'rails_helper'

feature 'Existing users CRUD shovel' do
  scenario 'index lists all available shovels with name, quantity' do
    maple_master = Shovel.new(name: 'Maple Master', quantity: 12)
    maple_master.save!
    hickory_shit_kicker = Shovel.new(name: 'Hickory Shit Kicker', quantity: 7)
    hickory_shit_kicker.save!
    sign_in_user

    expect(current_path).to eq shovels_path
    expect(page).to have_content 'Maple Master (Quantity: 12)'
    expect(page).to have_content 'Hickory Shit Kicker (Quantity: 7)'
  end

  scenario 'taken to a new shovel form from the index' do
    sign_in_user
    click_link 'New Shovel'

    expect(current_path).to eq new_shovel_path
  end

  scenario 'can make a new shovel from the new shovel form' do
    sign_in_user
    click_link 'New Shovel'
    fill_in :shovel_name, with: 'Ruby Red'
    fill_in :shovel_quantity, with: 201
    click_button 'Create Shovel'

    expect(current_path).to eq shovels_path
    expect(page).to have_content 'Ruby Red created successfully!'
    expect(page).to have_content 'Ruby Red (Quantity: 201)'
  end

  scenario 'index links to show via the shovel name and price' do
    oak_lord = Shovel.new(name: 'Oak Lord', quantity: 23)
    oak_lord.save!
    sign_in_user

    click_link 'Oak Lord (Quantity: 23)'

    expect(current_path).to eq shovel_path(oak_lord)
    expect(page).to have_content 'Shovel Name: Oak Lord'
    expect(page).to have_content 'Shovel Quantity: 23'
  end

  scenario 'show contains links to the index, edit, and destroy actions' do
    pine_power = Shovel.new(name: 'Pine Power', quantity: 7)
    pine_power.save!
    sign_in_user

    click_link 'Pine Power (Quantity: 7)'

    expect(current_path).to eq shovel_path(pine_power)
    expect(find_link('Index')[:href]).to eq(shovels_path)
    expect(find_link('Edit')[:href]).to eq(edit_shovel_path(pine_power))
    expect(find_link('Destroy')[:href]).to eq(shovel_path(pine_power))
  end

  scenario 'have the ability to go to an edit form from the show page' do
    oak_lord = Shovel.new(name: 'Oak Lord', quantity: 27)
    oak_lord.save!
    sign_in_user
    click_link 'Oak Lord (Quantity: 27)'
    click_link 'Edit'

    expect(current_path).to eq edit_shovel_path(oak_lord)
    expect(page).to have_content 'Editing the Oak Lord'
  end

  scenario 'can update shovels' do
    hickory_shit_kicker = Shovel.new(name: 'Hickory Shit Kicker', quantity: 27)
    hickory_shit_kicker.save!
    sign_in_user
    click_link 'Hickory Shit Kicker (Quantity: 27)'
    click_link 'Edit'
    expect(page).to have_content 'Editing the Hickory Shit Kicker'
    fill_in :shovel_name, with: 'Hickorymost'
    fill_in :shovel_quantity, with: 14
    click_button 'Update Shovel'

    expect(page).to have_content 'Hickorymost updated successfully!'
    expect(current_path).to eq(shovel_path(hickory_shit_kicker))
  end

  scenario 'clicking the destroy link on show page destroys the shovel and redirects to shovels index' do
    balsawood = Shovel.new(name: 'Balsawood', quantity: 1_700_000)
    balsawood.save!
    sign_in_user
    click_link 'Balsawood (Quantity: 1700000)'
    click_link 'Destroy'

    expect(page).to have_content 'Deleted shovel: Balsawood'
    expect(current_path).to eq shovels_path

    expect { balsawood.reload }.to raise_error ActiveRecord::RecordNotFound
  end
end

feature 'Unauthenticated users cannot request any CRUD path (available via GET)' do
  scenario 'instead are redirected to root_path and shown a flash message' do
    balsawood = Shovel.new(name: 'Balsawood', quantity: 730)
    balsawood.save!

    [shovels_path, new_shovel_path, shovel_path(balsawood), edit_shovel_path(balsawood)]. each do |path|
      visit path

      expect(current_path).to eq root_path
      expect(page).to have_content 'You must register or log in before you can do that! Fool!'
    end
  end
end
