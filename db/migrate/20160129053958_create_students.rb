class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students do |t|
      t.string :first_name
      t.string :last_name
      t.string :department
      t.integer :moz_number
      t.integer :manager_id

      t.timestamps
    end
  end
end
