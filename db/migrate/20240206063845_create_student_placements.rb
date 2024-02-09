class CreateStudentPlacements < ActiveRecord::Migration[7.1]
  def change
    create_table :student_placements do |t|
      t.references :company, foreign_key: true
      t.string :designation
      t.float :package
      t.text :requirements
      t.timestamps  
    end
  end
end
