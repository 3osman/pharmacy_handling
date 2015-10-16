class Template < ActiveRecord::Base
	has_one :med_table
	validates :name, :presence => true

end

