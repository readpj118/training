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

def create_user
  @user = User.new
  JSON.generate(@user)
end

def update_user
  @user = User.new
  @user.first_name = 'Joe'
  @user.last_name = 'Bloggs'
  JSON.generate(@user)
end