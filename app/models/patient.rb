class Patient < ActiveRecord::Base
	has_many :med_table
	validates :name, :presence => {:message => ' cannot be blank, Patient not saved'}

end
