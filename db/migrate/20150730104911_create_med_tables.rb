class CreateMedTables < ActiveRecord::Migration
  def change
    create_table :med_tables do |t|
      t.integer :patient_id

      t.timestamps null: false
    end
  end
end
