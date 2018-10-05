class BasePage

  def click_element(xpath, element_description)
    begin
      page.find(:xpath, xpath).click
    rescue
      fail("Unable to click element [#{element_description}] with xpath [#{xpath}]")
    end
  end

end