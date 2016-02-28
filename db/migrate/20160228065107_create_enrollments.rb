class CreateEnrollments < ActiveRecord::Migration
  def change
    create_table :enrollments do |t|
      t.integer :offer_date_id
      t.integer :student_id
      t.references :offer_date, index: true, foreign_key: true
      t.references :student, index: true, foreign_key: true
      t.timestamps
    end
  end
end