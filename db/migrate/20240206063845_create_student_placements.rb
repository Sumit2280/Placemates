class CreateStudentPlacements < ActiveRecord::Migration[7.1]
  def change
    create_table :student_placements do |t|
      t.references :companies, foreign_key: true
      t.string :first_name
      t.string :last_name
      t.string :branch
      t.string :batch
      t.string :designation
      t.float :package
      t.text :requirements
      t.string :email
      t.string :linkedin
      t.timestamps  
    end
  end
end
