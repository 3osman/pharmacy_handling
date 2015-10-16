class ChangeColumnNameMedtable < ActiveRecord::Migration
  def change
  	rename_column :med_tables, :template, :from_template
  end
end
