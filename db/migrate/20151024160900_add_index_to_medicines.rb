class AddIndexToMedicines < ActiveRecord::Migration
  def change
  	add_index :medicines, ["name", "m_type"], :unique => true
  end
end
