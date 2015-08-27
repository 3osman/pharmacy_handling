class AddTemplateToMedTable < ActiveRecord::Migration
  def change
    add_column :med_tables, :template, :boolean, :default => false
  end
end
