require 'test_helper'

class CreateUserTest < ActionDispatch::IntegrationTest
  test 'should set timezone' do
    cookies[:timezone] = "America/Chicago"
    post '/users', params: {
      user: {
        email: 'user@example.com',
        password: 'password'
      }
    }

    user = User.last.reload

    assert_not_nil(user.timezone)
    assert_equal('America/Chicago', user.timezone)
  end
end
