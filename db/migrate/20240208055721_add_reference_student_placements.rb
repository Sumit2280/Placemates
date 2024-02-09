class AddReferenceStudentPlacements < ActiveRecord::Migration[7.1]
  def change
    add_reference :student_placements, :user, index: true, foreign_key: true
  end
end
