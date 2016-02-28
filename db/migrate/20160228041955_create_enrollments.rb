class CreateEnrollments < ActiveRecord::Migration
  def change
    create_table :enrollments do |t|
      t.integer :course_id
      t.integer :student_id
      t.references :courses, index: true, foreign_key: true
      t.references :students, index: true, foreign_key: true
      t.timestamps
    end
  end
end