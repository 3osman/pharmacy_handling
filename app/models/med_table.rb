class MedTable < ActiveRecord::Base
	belongs_to :patient
	belongs_to :template
	has_many :med_table_entries
end
