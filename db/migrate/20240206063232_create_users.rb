class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.references :roles, foreign_key: true
      t.string :email
      t.string :password_digest 
      t.string :first_name
      t.string :last_name
      t.string :branch
      t.string :batch
      t.boolean :placed
      t.references :blogs, foreign_key: true
      t.timestamps
    end
  end
end
