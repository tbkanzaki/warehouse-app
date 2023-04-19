class RenameFieldNameInWarehouses < ActiveRecord::Migration[7.0]
  def change
    rename_column :warehouses, :codigo, :code
  end
end
