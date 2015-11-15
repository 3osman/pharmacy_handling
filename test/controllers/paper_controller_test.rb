require 'test_helper'

class PaperControllerTest < ActionController::TestCase
  include Devise::TestHelpers
  include FactoryGirl::Syntax::Methods
  setup do
    @user = FactoryGirl.create :admin
    sign_in @user
  end
  test "should get first_step" do
    get :first_step
    assert_response :success
  end

  

end
