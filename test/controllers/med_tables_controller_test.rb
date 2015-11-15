require 'test_helper'

class MedTablesControllerTest < ActionController::TestCase
  include Devise::TestHelpers
  include FactoryGirl::Syntax::Methods
  setup do
  	@controller = MedTablesController.new
    @user = FactoryGirl.create :admin
    sign_in @user
  end
  test "should get view" do
    get :view
    assert_response :success
  end

end
