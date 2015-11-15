require 'test_helper'

class StaticPagesControllerTest < ActionController::TestCase
  include Devise::TestHelpers
  include FactoryGirl::Syntax::Methods
  def setup
    @user = FactoryGirl.create :user
    sign_in @user 
  end

  test "should get home" do
    get :home
    assert_response :success
  end

end
