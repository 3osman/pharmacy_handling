class RenameType < ActiveRecord::Migration
  def change
    rename_column :medicines, :type, :m_type
  end
end
