class CreateUserApplications < ActiveRecord::Migration[7.1]
  def change
    create_table :user_applications do |t|
      t.references :user, foreign_key: true
      # t.references :opportunity, foreign_key: true
      t.string :status
      t.timestamps
    end
  end
end
