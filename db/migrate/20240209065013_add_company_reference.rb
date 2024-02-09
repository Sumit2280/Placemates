class AddCompanyReference < ActiveRecord::Migration[7.1]
  def change
    add_reference :user_applications, :opportunity, index: true, foreign_key: true
  end
end
