class CreateTestimonials < ActiveRecord::Migration[7.1]
  def change
    create_table :testimonials do |t|
      t.references :user, foreign_key: true
      t.string :title
      t.text :description
      t.timestamps
    end
  end
end
