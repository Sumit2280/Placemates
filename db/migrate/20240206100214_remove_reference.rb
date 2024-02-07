class RemoveReference < ActiveRecord::Migration[7.1]
  def change
    remove_reference :users, :blogs, index: true, foreign_key: true
  end
end
