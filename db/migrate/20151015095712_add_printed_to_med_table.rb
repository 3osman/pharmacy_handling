class AddPrintedToMedTable < ActiveRecord::Migration
  def change
    add_column :med_tables, :printed, :boolean
  end
end
