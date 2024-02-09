class RemoveTable < ActiveRecord::Migration[7.1]
  def change
    drop_table :blogs
  end
end
