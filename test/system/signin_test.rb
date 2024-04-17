require "application_system_test_case"
require "yaml"

class SigninTest < ApplicationSystemTestCase
  include Devise::Test::IntegrationHelpers
  setup do
    @signin_scenarios = load_signin_scenarios
  end

  test "successfull sign in" do
    sign_in users(:bob)
    visit root_path
    
    assert_text 'Home'
    assert_text 'Sign out'
  end

  test "unsuccessfull sign in" do
    go_to_signin
    fill_in 'Email', with: @signin_scenarios['invalid_user']['invalid_email']
    fill_in 'Password', with: @signin_scenarios['invalid_user']['invalid_password']
    click_on 'Log in'
    assert_text 'Invalid Email or password.'
  end

  protected

  def load_signin_scenarios
    YAML.load_file('test/data/signin_scenarios.yml')
  end

  def go_to_signin
    visit root_path
    click_on 'Sign in'
  end    
end