class RemoveFieldNameFromStudents < ActiveRecord::Migration
  def change
    remove_column :students, :title, :text
  end
end
