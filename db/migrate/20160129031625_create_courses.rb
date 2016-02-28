class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :name
      t.string :catalog
      t.text :description
      t.integer :size
      t.timestamps
    end
  end
end
