class CreateMedicines < ActiveRecord::Migration
  def change
    create_table :medicines do |t|
      t.string :name
      t.boolean :availability
      t.integer :quantity
      t.string :usage
      t.string :side_effects

      t.timestamps null: false
    end
  end
end
