class CreateOpportunities < ActiveRecord::Migration[7.1]
  def change
    create_table :opportunities do |t|
      t.references :company, foreign_key: true
      t.string :status
      t.integer :no_of_applications
      t.string :designation
      t.string :skillset
      t.float :package
      t.date :start_date
      t.date :end_date
      t.timestamps
    end
  end
end
