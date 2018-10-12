class User

  attr_accessor :first_name, :last_name, :movies, :address, :email, :password

  def initialize
    @first_name = 'Test'
    @last_name = 'Tester'
    @credentials = Credentials.new
    @movies =['Jaws', 'ET', 'Star Wars']
    @address= [UserAddress.new]
  end
end