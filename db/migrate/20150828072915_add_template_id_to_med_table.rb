class AddTemplateIdToMedTable < ActiveRecord::Migration
  def change
    add_column :med_tables, :template_id, :integer
  end
end
