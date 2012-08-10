require 'test_helper'

class SessionControllerTest < ActionController::TestCase
  def test_show
    get(:show)
    assert_response(:success)
  end

  def test_create_on_success
    post(:create, session: {email: 'alice@example.com', password: 'password'})
    assert_equal(users(:alice).id, session[:user_id])
    assert_response(:redirect)
  end

  def test_create_on_failure
    post(:create, session: {email: 'doesnt@exist.com', password: 'password'})
    assert_template('session/show')
    assert_response(:success)
  end
end
