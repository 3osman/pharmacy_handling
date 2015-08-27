class AddDateToMedTables < ActiveRecord::Migration
  def change
    add_column :med_tables, :pre_date, :date
  end
end
