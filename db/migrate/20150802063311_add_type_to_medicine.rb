class AddTypeToMedicine < ActiveRecord::Migration
  def change
    add_column :medicines, :type, :string
  end
end
