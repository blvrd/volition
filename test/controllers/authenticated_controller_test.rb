require 'test_helper'

class AuthenticatedControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:garrett)
  end

  test 'should require a user to be signed in' do
    get dashboard_path

    assert_redirected_to(login_path)

    login_as(@user)

    get dashboard_path

    assert_response(:ok)
  end

  test 'should require a user to have paid in non self hosted version' do
    @user.update(paid: false)

    login_as(@user)

    get dashboard_path

    assert_redirected_to(settings_path)

    @user.update(paid: true)

    get dashboard_path

    assert_response(:ok)
  end

  test 'doesnt require a user to have paid in the self hosted version' do
    ClimateControl.modify(SELF_HOSTED: 'true') do
      @user.update(paid: false)

      login_as(@user)

      get dashboard_path

      assert_response(:ok)
    end
  end
end
