class MedTable < ActiveRecord::Base
	belongs_to :patient
	has_many :med_table_entries
end
