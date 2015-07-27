class CreatePatients < ActiveRecord::Migration
  def change
    create_table :patients do |t|
      t.string :name
      t.integer :age
      t.date :first_check_in

      t.timestamps null: false
    end
  end
end
