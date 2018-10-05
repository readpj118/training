class CheckBoxesPage < BasePage
  include Capybara::DSL
  attr_reader :checkbox_one_xpath, :checkbox_two_xpath

  def initialize
    @checkbox_one_xpath = '//*[@id="checkboxes"]/input[1]'
    @checkbox_two_xpath = '//*[@id="checkboxes"]/input[2]'
  end

  def click_checkbox_one
    page.find(:xpath, @checkbox_one_xpath).click
  end


  def click_checkbox_two
    page.find(:xpath, @checkbox_two_xpath).click
  end
end