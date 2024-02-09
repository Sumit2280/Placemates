class AddReference < ActiveRecord::Migration[7.1]
  def change
    # add_reference :companies, :student_placements, index: true, foreign_key: true
    # add_reference :blogs, :user, index: true, foreign_key: true
    add_reference :company_placements, :company, index: true, foreign_key: true
    # add_reference :student_placements, :users, index: true, foreign_key: true
  end
end
