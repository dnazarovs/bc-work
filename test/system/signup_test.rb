require "application_system_test_case"
require "yaml"

class SignupTest < ApplicationSystemTestCase
  setup do
    @signup_scenarios = load_signup_scenarios
    go_to_signup
  end

  test "valid sign up" do
    perform_signup(@signup_scenarios['valid']['valid_user'])
    assert_text 'Welcome! You have signed up successfully.'
  end

  test "blank email sign up" do
    perform_signup(@signup_scenarios['invalid']['blank_email'])
    assert_text 'Email can\'t be blank'
  end

  test "invalid email" do
    perform_signup(@signup_scenarios['invalid']['invalid_email'])
    assert_text 'Email is invalid'
  end

  test "blank name sign up" do 
    perform_signup(@signup_scenarios['invalid']['blank_name'])
    assert_text 'Name can\'t be blank'
  end

  test "invalid name sign up" do
    perform_signup(@signup_scenarios['invalid']['invalid_name'])
    assert_text 'Name should include only symbols'
  end

  test "blank last name sign up" do
    perform_signup(@signup_scenarios['invalid']['blank_last_name'])
    assert_text 'Last name can\'t be blank'
  end

  test "invalid last name sign up" do
    perform_signup(@signup_scenarios['invalid']['invalid_last_name'])
    assert_text 'Last name should include only symbols'
  end

  test "blank age sign up" do
    perform_signup(@signup_scenarios['invalid']['blank_age'])
    assert_text 'Age can\'t be blank'
  end

  test "age less than 18 sign up" do
    perform_signup(@signup_scenarios['invalid']['age_below_18'])
    assert_text 'Age must be greater than 17'
  end

  test "age is not a number sign up" do
    perform_signup(@signup_scenarios['invalid']['age_not_a_number'])
    assert_text 'Age is not a number'
  end

  test "age is not an integer sign up" do
    perform_signup(@signup_scenarios['invalid']['age_not_an_integer'])
    assert_text 'Age must be an integer'
  end

  test "blank password sign up" do
    perform_signup(@signup_scenarios['invalid']['blank_password'])
    assert_text 'Password can\'t be blank'
  end

  test "password too short sign up" do
    perform_signup(@signup_scenarios['invalid']['password_too_short'])
    assert_text 'Password is too short (minimum is 6 characters)'
  end

  test "password confirmation doesn't match password" do
    perform_signup(@signup_scenarios['invalid']['password_confirmation_doesnt_match'])
    assert_text 'Password confirmation doesn\'t match Password'
  end

  protected

  def go_to_signup
    visit root_path
    click_on 'Sign up'
  end

  def load_signup_scenarios
    YAML.load_file(Rails.root.join('test/data/signup_scenarios.yml'))
  end
  
  def perform_signup(scenario_data)
    fill_in 'Email', with: scenario_data['email']
    fill_in 'Name', with: scenario_data['name']
    fill_in 'Last name', with: scenario_data['last_name']
    fill_in 'Age', with: scenario_data['age']
    fill_in 'Password', with: scenario_data['password']
    fill_in 'Password confirmation', with: scenario_data['password_confirmation']
    click_on 'Create account!'
  end
end
