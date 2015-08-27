require 'test_helper'

class MedTablesControllerTest < ActionController::TestCase
  test "should get view" do
    get :view
    assert_response :success
  end

end
