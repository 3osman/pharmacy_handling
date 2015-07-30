class CreateMedTableEntries < ActiveRecord::Migration
  def change
    create_table :med_table_entries do |t|
      t.integer :med_table_id
      t.integer :medicine_id
      t.string :instruction
      t.string :duration
      t.string :morning
      t.string :afternoon
      t.string :evening

      t.timestamps null: false
    end
  end
end
