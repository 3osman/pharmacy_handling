require 'test_helper'

class PaperControllerTest < ActionController::TestCase
  test "should get first_step" do
    get :first_step
    assert_response :success
  end

  test "should get generate_pdf" do
    get :generate_pdf
    assert_response :success
  end

end
