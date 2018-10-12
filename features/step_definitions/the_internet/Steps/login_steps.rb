checkboxes = CheckBoxesPage.new

Given(/^I visit the login page$/) do
  visit('/login')
end

When(/^I login with correct credentials$/) do
  expect(page).to have_text('Login Page')
  page.fill_in('Username', :with => TestConfig['username'])
  page.fill_in('Password', :with => TestConfig['password'])
  page.click_button('Login')
end

Then(/^I am logged into the secure area$/) do
  expect(page).to have_text('You logged into a secure area!'), 'Access denied'
end

Given(/^I visit the checkbox page$/) do
  visit('/checkboxes')
end

When(/^I tick the first checkbox$/) do
  # page.find(:xpath, '//*[@id="checkboxes"]/input[1]').click
  # checkboxes.click_checkbox_one
  checkboxes.click_element(checkboxes.checkbox_one_xpath, 'Checkbox 1')
end

Then(/^the checkbox is ticked$/) do
  # expect(page.find(:xpath, '//*[@id="checkboxes"]/input[1]').checked?).to eq false
  expect(page.find(:xpath, checkboxes.checkbox_one_xpath).checked?).to eq true
end