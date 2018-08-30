class HelloWorld

  def initialize
    @first_name = ''
    @surname = ''

  end

  def get_string
    gets.chomp
  end

  def enter_first_name
    p 'Please enter your firstname'
    @first_name = get_string
  end

  def enter_surname
    p 'Please enter your surname'
    @surname = get_string
  end

  def print_name
    puts ('Hello ' + @first_name + ' ' + @surname)
  end

end

hello_world = HelloWorld.new
hello_world.enter_first_name
hello_world.enter_surname
hello_world.print_name
