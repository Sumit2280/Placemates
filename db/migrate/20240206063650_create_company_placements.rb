class CreateCompanyPlacements < ActiveRecord::Migration[7.1]
  def change
    create_table :company_placements do |t|
      t.string :year
      t.integer :applied
      t.integer :selected
      t.timestamps
    end
  end
end
