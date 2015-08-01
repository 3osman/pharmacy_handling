class ChangeQuantityDefault < ActiveRecord::Migration
  def change
  		change_column :medicines, :quantity, :integer, :default => nil

  end
end
