class MedTableEntry < ActiveRecord::Base
	belongs_to :med_table
	belongs_to :medicine
end
