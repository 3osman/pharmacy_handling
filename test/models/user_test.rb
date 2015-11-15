require 'test_helper'

class UserTest < ActiveSupport::TestCase
   test "User saves with all parameters" do
    user = User.create(username: 'username', email: 'adsad', admin: false, password: 'hghf')
    assert user.valid?, 'The user was not valid when all parameters were supplied' 
    assert_equal 'username', user.username, 'User username does not match'
  end

  test "user doesn't save without username" do
	user = User.create(email: 'adsad', admin: false, password: 'hghf')   
  	assert_not user.valid?, 'The user was valid when username wasnt supplied' 
    
  end

  test "user index on username" do
    user = User.create(username: 'username', email: 'adsad', admin: false, password: 'hghf')
    assert user.valid?, 'First user not saved'
    assert_raises ActiveRecord::RecordNotUnique do
    	use = User.create(username: 'username', email: 'ad', admin: false, password: 'hghf')
 	end
  end
end
