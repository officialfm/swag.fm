require 'test_helper'

class SessionControllerTest < ActionController::TestCase
  def test_index
    get(:index)
    assert_response(:success)
  end

  def test_create_on_success
    post(:create, email: 'alice@example.com', password: 'password')
    assert_equal(users(:alice).id, session[:user_id])
    assert_response(:redirect)
  end

  def test_create_on_failure
    post(:create, email: 'doesnt@exist.com', password: 'password')
    assert_template('session/index')
    assert_response(:success)
  end
end
