require 'test_helper'

class ExtensionsControllerTest < ActionController::TestCase
  
  def test_chrome
    get :chrome, format: :xml
    assert_response :success    
  end

end
