class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.references :role, foreign_key: true
      t.string :email
      t.string :password_digest 
      t.string :first_name
      t.string :last_name
      t.string :branch
      t.string :batch
      t.boolean :placed
      t.string :linkedin
      t.timestamps
    end
  end
end
