# frozen_string_literal: true

Given('the following states exist:') do |state_table|
  state_table.hashes.each do |state_params|
    State.create(state_params)
  end
end

Then /(.*) seed states should exist/ do |n_seeds|
  expect(State.count).to eq n_seeds.to_i
end

When('I visit the map index page') do
  visit root_path
end

Then('I should see a map with the states {string} and {string}') do |state1, state2|
  expect(page).to have_content(state1)
  expect(page).to have_content(state2)
end

When('I visit the state map page for {string}') do |state_symbol|
  visit state_map_path(state_symbol)
end

Then('I should see the map with details for {string} state') do |state_name|
  expect(page).to have_content(state_name)
  expect(page).not_to have_content('State not found')
end
