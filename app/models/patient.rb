class Patient < ActiveRecord::Base
	has_many :med_table
end
