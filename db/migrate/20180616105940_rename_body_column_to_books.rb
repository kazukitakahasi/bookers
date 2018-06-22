class RenameBodyColumnToBooks < ActiveRecord::Migration[5.1]
  def change
  	rename_column :books, :body, :opinion
  end
end
