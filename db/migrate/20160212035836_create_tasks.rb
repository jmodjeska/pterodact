class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.integer :course_id
      t.string :name
      t.datetime :due_date
      t.references :courses, index: true, foreign_key: true

      t.timestamps
    end
  end
end
