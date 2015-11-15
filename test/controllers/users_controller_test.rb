require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  include Devise::TestHelpers
  include FactoryGirl::Syntax::Methods
  setup do
    @user = FactoryGirl.create :user
    sign_in @user
  end
# test "the truth" do
  #   assert true
  # end
end
