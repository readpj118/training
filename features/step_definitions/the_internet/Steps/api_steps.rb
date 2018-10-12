Given(/^I want to add a user$/) do
  @json = create_user
  @request = 'post'
end

Given(/^I want to get the users$/) do
  @request = 'get'
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
    when 'register'
      send_post(TestConfig['host'], '/api/register', @json)
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

And(/^the user is updated$/) do
  expect(JSON.parse(@response.body)['updatedAt'].to_s[0..9]).to eq(Time.now.to_s[0..9])
end

Given(/^I want to register a user with email (.*) and password (.*)$/) do |email, password|
  @register_user = Credentials.new
  @register_user.email = email
  @register_user.password = password
  @json = JSON.generate(@register_user)
end

Then(/^the following (.*) is returned$/) do |response|
  p @response.code
  p @response.message
  p JSON.parse(@response.body)['error']
  expect(JSON.parse(@response.body)['error']).to eq(response)
end

Then(/^the response is a success$/) do
  p @response.code
  p @response.message
  expect(@response.code).to eq('200')
  expect(@response.message).to eq('OK')
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


Then(/^the response is a no content$/) do
  p @response.code
  p @response.message
  expect(@response.code).to eq('204')
  expect(@response.message).to eq('No Content')
end