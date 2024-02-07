class CreateCompanies < ActiveRecord::Migration[7.1]
  def change
    create_table :companies do |t|
      t.references :company_placements, foreign_key: true
      t.string :name
      t.string :information
      t.string :website
      t.timestamps
    end
  end
end
