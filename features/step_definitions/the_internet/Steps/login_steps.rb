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


Given(/^I want to add a user$/) do
  @json = create_user
  @request = 'post'
end

Given(/^I want to get the users$/) do
  @request = 'get'
end


def send_post(host, path, json)
  url = URI(host + path)
  http = Net::HTTP.new(url.host, url.port)
  if TestConfig['secure_scheme']
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
  end
  request = Net::HTTP::Post.new(url)
  request['Content-Type'] = 'application/json'
  request.body = json
  @response = http.request(request)
end

def send_get(host, path)
  url = URI(host + path)
  http = Net::HTTP.new(url.host, url.port)
  if TestConfig['secure_scheme']
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
  end
  request = Net::HTTP::Get.new(url)
  request['Content-Type'] = 'application/json'
  @response = http.request(request)
end

def send_delete(host, path)
  url = URI(host + path)
  http = Net::HTTP.new(url.host, url.port)
  if TestConfig['secure_scheme']
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
  end
  request = Net::HTTP::Delete.new(url)
  request['Content-Type'] = 'application/json'
  @response = http.request(request)
end

def send_put(host, path, json)
  url = URI(host + path)
  http = Net::HTTP.new(url.host, url.port)
  if TestConfig['secure_scheme']
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
  end
  request = Net::HTTP::Put.new(url)
  request['Content-Type'] = 'application/json'
  request.body = json
  @response = http.request(request)
end

def send_get_with_parameters(host, path, parameters)
  url = URI(host + path)
  url.query = parameters
  http = Net::HTTP.new(url.host, url.port)
  if TestConfig['secure_scheme']
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
  end
  request = Net::HTTP::Get.new(url)
  request['Content-Type'] = 'application/json'
  @response = http.request(request)
end

Then(/^the response is a success$/) do
  p @response.code
  p @response.message
  expect(@response.code).to eq('200')
  expect(@response.message).to eq('OK')
end

def create_user
  @user = User.new
  JSON.generate(@user)
end

Then(/^the user is added$/) do
  p @response.code
  p @response.message
  expect(@response.code).to eq('201')
  expect(JSON.parse(@response.body)['first_name']).to eq(@user.first_name)
  expect(JSON.parse(@response.body)['last_name']).to eq(@user.last_name)
  expect(JSON.parse(@response.body)['createdAt'].to_s[0..9]).to eq(Time.now.to_s[0..9])
  id = JSON.parse(@response.body)['id']
  p "Your User ID is: #{id}"
end


When(/^I send an api (.*) request$/) do |method|
  case method.downcase
    when 'get'
      send_get(TestConfig['host'], '/api/users')
    when 'post'
      send_post(TestConfig['host'], '/api/users', @json)
    when 'get with parameters'
      send_get_with_parameters(TestConfig['host'], '/api/users', @parameters)
    when 'delete'
      send_delete(TestConfig['host'], '/api/users/13')
    when 'put'
      send_put(TestConfig['host'], '/api/users/1', @json)
    else
      raise('Method' + method + 'does not exist')
  end
end

And(/^I want to get (.*) page with (.*) users per page$/) do |page, number_of_users|
  @parameters = "page=#{page}&per_page=#{number_of_users}"
end

And(/^the response displays (.*) page with (.*) users per page$/) do |page, number_of_users|
  p JSON.parse(@response.body)['page']
  p JSON.parse(@response.body)['per_page']
  expect(JSON.parse(@response.body)['page']).to eq(page.to_i)
  expect(JSON.parse(@response.body)['per_page']).to eq(number_of_users.to_i)
end

Given(/^I want to delete a user$/) do
  @request = 'delete'
end

Given(/^I want to update a user$/) do
  @json = update_user
  @request = 'put'
end

def update_user
  @user = User.new
  @user.first_name = 'Joe'
  @user.last_name = 'Bloggs'
  JSON.generate(@user)
end


And(/^the user is updated$/) do
  expect(JSON.parse(@response.body)['updatedAt'].to_s[0..9]).to eq(Time.now.to_s[0..9])
end