class CreateTemplates < ActiveRecord::Migration
  def change
    create_table :templates do |t|
      t.string :name
      t.string :symptoms
      t.string :duration

      t.timestamps null: false
    end
  end
end
