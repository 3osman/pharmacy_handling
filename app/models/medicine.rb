class Medicine < ActiveRecord::Base
	validates :name, :presence => {:message => 'cannot be blank, Medicine not saved'}
	

end
