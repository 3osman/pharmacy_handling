class Medicine < ActiveRecord::Base
	validates :name, :presence => {:message => 'cannot be blank, Medicine not saved'}
	has_many :med_table_entries
end
